import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/pages/home_page.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Medcy',

        //theme customization
        theme: ThemeData.dark().copyWith(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kScaffoldColor,
            appBarTheme: AppBarTheme(
                toolbarHeight: 7.h,
                backgroundColor: kScaffoldColor,
                elevation: 0,
                iconTheme: IconThemeData(color: kSecondaryColor, size: 20.sp),
                titleTextStyle: GoogleFonts.mulish(
                  color: kTextColor,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                )),
            textTheme: TextTheme(
                headline2: TextStyle(
                  fontSize: 28.sp,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w400,
                ),
                headline4: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: kTextColor),
                subtitle2:
                    GoogleFonts.poppins(fontSize: 12.sp, color: kTextColor),
                caption: GoogleFonts.poppins(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
                labelMedium: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: kTextColor)),
            inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: kTextLightColor,
                  width: 0.7,
                )),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: kTextLightColor),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)))),

        home: const HomePage(),
      );
    });
  }
}
