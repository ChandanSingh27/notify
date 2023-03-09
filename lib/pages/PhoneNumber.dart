
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notify/helperclass/HelperClass.dart';
import 'package:notify/pages/verifyphonenumber.dart';
import 'package:notify/provider/phoneAuthenticationProvider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';


class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {

  final _key = GlobalKey<FormState>();

  check(){
    if(_key.currentState!.validate()){
      context.read<PhoneAuthenticationProvider>().verifyPhoneNumber(context);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(HelperClass.defaultPadding),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: HelperClass.defaultPadding,),
                  Lottie.asset("assets/lottie/login.json",width: 250,height: 250),
                  Text("Enter your\n mobile number",style: Theme.of(context).textTheme.headline1,),
                  SizedBox(height: HelperClass.defaultPadding/2,),
                  Text("We will send you confirmation code",style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: HelperClass.defaultPadding*4,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: HelperClass.textColor
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        TextButton(onPressed: (){
                          showCountryPicker(
                            countryListTheme: CountryListThemeData(
                              borderRadius: BorderRadius.circular(5),
                              backgroundColor: HelperClass.scaffoldBackgroundColor,
                              bottomSheetHeight: MediaQuery.of(context).size.height/2,
                              textStyle: TextStyle(color: HelperClass.textColor),
                              inputDecoration: InputDecoration(
                                label: const Text("Search Country Code"),
                                labelStyle: Theme.of(context).textTheme.headline1,
                                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 5,),)
                              ),
                              searchTextStyle: const TextStyle(color: Colors.white)
                            ),
                            context: context,
                            showPhoneCode: true, // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              context.read<PhoneAuthenticationProvider>().changeCountryCode(country.phoneCode.toString());
                            },
                          );
                        }, child: Text(context.watch<PhoneAuthenticationProvider>().countryCode,style: Theme.of(context).textTheme.subtitle1,),),
                        SizedBox(height: 30,child: VerticalDivider(width: 2,color: HelperClass.textColor,thickness: 2),),
                        SizedBox(width: HelperClass.defaultPadding/2,),
                        Flexible(child: TextFormField(
                          controller: context.watch<PhoneAuthenticationProvider>().phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: Theme.of(context).textTheme.subtitle1
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Please Enter the Phone Number";
                            }else if(value.length != 10){
                              return "Please Enter the correct Phone Number";
                            }else{
                              return null;
                            }
                          },
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: HelperClass.defaultPadding*2,),
                  Flexible(child: Container()),
                  Align(
                    alignment: Alignment.center,
                      child: CustomButton(callback: check,buttonName: "Login",isLoading: context.watch<PhoneAuthenticationProvider>().isLoading,)),
                  SizedBox(height: HelperClass.defaultPadding*2,),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
