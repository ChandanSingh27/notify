import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notify/helperclass/HelperClass.dart';
import 'package:notify/provider/phoneAuthenticationProvider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyPhoneNumber extends StatefulWidget {
  String verificationId;
  VerifyPhoneNumber({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PhoneAuthenticationProvider>().startCounter();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(HelperClass.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: HelperClass.defaultPadding,),
              Lottie.asset("assets/lottie/otp.json",width: 250,height: 250),
              SizedBox(height: HelperClass.defaultPadding,),
              Text("Enter code sent\nto your phone",style: Theme.of(context).textTheme.headline1,),
              SizedBox(height: HelperClass.defaultPadding,),
              Text("We sent it to the number ${context.watch<PhoneAuthenticationProvider>().userPhoneNumber}",style: Theme.of(context).textTheme.subtitle1,),
              SizedBox(height: HelperClass.defaultPadding*4,),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  child: PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      activeColor: Colors.white,
                      selectedFillColor: HelperClass.buttonBackgroundColor,
                      selectedColor: Colors.white,
                      inactiveColor: Colors.white,
                      inactiveFillColor: Colors.white.withOpacity(0.9),
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),

                    enableActiveFill: true,
                    onCompleted: (v) {
                      context.read<PhoneAuthenticationProvider>().signInWithCredential(widget.verificationId, v.toString(),context);
                    },
                    onChanged: (value) {

                    }, appContext: context,

                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Align(alignment:Alignment.center,child: TextButton(onPressed: context.watch<PhoneAuthenticationProvider>().resendOptions? context.read<PhoneAuthenticationProvider>().startCounter():null, child: Text(context.watch<PhoneAuthenticationProvider>().resendOptions?"Resend Code":"Resend Code : ${context.watch<PhoneAuthenticationProvider>().time.toString()}",style: TextStyle(color:context.watch<PhoneAuthenticationProvider>().resendOptions? Colors.blue:Colors.white),)))
            ],
          ),
        ),
      ),
    );
  }
}
