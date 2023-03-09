import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notify/pages/homepage.dart';
import 'package:notify/pages/verifyphonenumber.dart';
import 'package:notify/provider/formprovider.dart';
import 'package:provider/provider.dart';

class PhoneAuthenticationProvider with ChangeNotifier {

  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  final TextEditingController phoneNumberController = TextEditingController();
  var countryCode = "+91";
  String userPhoneNumber = "";
  int time = 30;
  bool resendOptions = false;


  changeCountryCode(String code) {
    countryCode = "+$code";
    notifyListeners();
  }
  toggle(){
    isLoading = !isLoading;
    notifyListeners();
  }
  counter(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(time == 0){
        resendOptions = true;
        timer.cancel();
        notifyListeners();
      }else{
        time--;
        notifyListeners();
      }
    });
  }

  startCounter(){
    resendOptions = false;
    time = 30;
    notifyListeners();
    counter();
  }

  verifyPhoneNumber(BuildContext context) async {
    
    try{
      toggle();
      String phoneNumber = countryCode+phoneNumberController.text.trim();
      userPhoneNumber = phoneNumber;
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (AuthCredential authCredential) {

        },
        verificationFailed: (error) {

        },
        codeSent: (verificationId, forceResendingToken) {
          Get.to(VerifyPhoneNumber(verificationId: verificationId),transition: Transition.leftToRightWithFade,duration: const Duration(seconds: 1));
        },
        codeAutoRetrievalTimeout: (String verificationId) {  },

      );
    }catch(error){
      print("number send error : ${error.toString()}");
    }finally{
      toggle();
    }
    notifyListeners();
  }

  signInWithCredential (String verificationId,String smsCode,BuildContext context) async{
      try{
        final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        await auth.signInWithCredential(credential).then((value) async {
          Get.to(const HomeScreen());
        });
      }catch(error){
        print(error.toString());
      }
  }

}

// ontext.watch<FormProvider>().nameController.text