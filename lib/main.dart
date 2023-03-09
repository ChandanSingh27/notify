import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notify/pages/PhoneNumber.dart';
import 'package:notify/pages/formpage.dart';
import 'package:notify/pages/homepage.dart';
import 'package:notify/provider/formprovider.dart';
import 'package:notify/provider/phoneAuthenticationProvider.dart';
import 'package:provider/provider.dart';
import 'helperclass/HelperClass.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PhoneAuthenticationProvider(),),
      ChangeNotifierProvider(create: (context) => FormProvider(),)
    ],
      child: const NotifyApp()));
}

class NotifyApp extends StatelessWidget {
  const NotifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: HelperClass.scaffoldBackgroundColor,
          textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: HelperClass.textColor
              ),
              subtitle1: TextStyle(
                  color: HelperClass.textColor
              )
          ),
          fontFamily: GoogleFonts.lato().fontFamily
      ),
      home: const HomeScreen(),
    );
  }
}
