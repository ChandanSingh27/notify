import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notify/helperclass/HelperClass.dart';
import 'package:notify/provider/formprovider.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(HelperClass.defaultPadding*3),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign Up Page",style: Theme.of(context).textTheme.headline1,),
                SizedBox(height: HelperClass.defaultPadding*4,),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      Provider.of<FormProvider>(context,listen: false).showPhotoOptions(context);
                      setState(() {

                      });
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: (Provider.of<FormProvider>(context).imageFile != null) ? FileImage(Provider.of<FormProvider>(context).imageFile!) : null,
                      child: Container(alignment:Alignment.center,height:25,width:25,decoration: const BoxDecoration(color: Colors.white,shape: BoxShape.circle),child: Icon(CupertinoIcons.add,size: 20,),),
                    )
                  ),
                ),
                SizedBox(height: HelperClass.defaultPadding,),
                Align(alignment:Alignment.center,child: Text("Choose your profile",style: Theme.of(context).textTheme.subtitle1,)),
                SizedBox(height: HelperClass.defaultPadding*4,),
                Flexible(child: TextFormField(
                  controller: context.watch<FormProvider>().fullNameController,
                  decoration: const InputDecoration(
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.white),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    )
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Enter the name...';
                    }else{
                      return null;
                    }
                  },
                )),
                SizedBox(height: HelperClass.defaultPadding*4,),
                Align(
                  alignment: Alignment.center,
                    child: CustomButton(callback: (){
                      if(key.currentState!.validate()){
                          if(Provider.of<FormProvider>(context,listen: false).imageFile != null){
                            
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please upload the image"),duration: Duration(seconds: 1),backgroundColor: HelperClass.scaffoldBackgroundColor.withOpacity(.5),));
                          }
                      }
                    }, buttonName: "Upload", isLoading: false)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
