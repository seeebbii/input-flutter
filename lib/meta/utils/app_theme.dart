import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static const Color darkBackgroundColor = Color(0xFF0B0B0B);
  // static const Color darkBackgroundColor = Color(0xFF181C1E);
  static const Color darkCardColor = Color(0xFF262F34);
  static const Color darkLightColor = Color(0xFF656D77);
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightComponentsColor = Color(0xFF40CAFF);
  static const Color whiteColor = Color(0xFFF4F8FA);
  static const Color primaryColor = Color(0xFF206BC4);
  static const Color errorColor = Color(0xFFD73A49);

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Consolas',
      canvasColor: darkBackgroundColor,
      primaryColor: darkBackgroundColor,
      backgroundColor: darkBackgroundColor,
      unselectedWidgetColor: Colors.blueGrey.withOpacity(0.4),
      scaffoldBackgroundColor: darkBackgroundColor,
      primaryColorLight: const Color(0xFF2D333A),
      focusColor: const Color(0xFF444C56),
      errorColor: errorColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.white,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          letterSpacing: 2.7,
          fontSize: 32.sp,
        ),
        headline2: TextStyle(
          color: whiteColor,
          fontSize: 11.sp,
        ),
        bodyText1: TextStyle(
          color: whiteColor,
          fontSize: 12.sp,
        ),
        bodyText2: TextStyle(
          color: whiteColor,
            fontSize: 13.sp
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xFF6E7681),
        brightness: Brightness.dark,
      ),
    );
  }
}