
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelperClass{
  static double defaultPadding = 10;
  static Color scaffoldBackgroundColor = const Color(0xff0c0c0f);
  static Color textColor = const Color(0xffE1E1E5);
  static Color tabBarBackGroundColor = const Color(0xff13131A);
  static Color buttonBackgroundColor = const Color(0xffE5E1E1);
}


class CustomButton extends StatelessWidget {

  VoidCallback callback;
  String buttonName;
  bool isLoading;
  CustomButton({Key? key,required this.callback,required this.buttonName,required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 50,
        width: 250,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HelperClass.buttonBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: HelperClass.buttonBackgroundColor.withOpacity(0.7),blurRadius: 10,spreadRadius: 2)]
        ),
        child: isLoading?const CircularProgressIndicator(color: Colors.black,):Text(buttonName,style: TextStyle(fontSize: 18,color: HelperClass.scaffoldBackgroundColor),),
      ),
    );
  }
}
