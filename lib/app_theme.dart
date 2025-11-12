import 'package:flutter/material.dart';

class AppColors {
  static const Color ocre = Color(0xFFC08457);
  static const Color gold = Color(0xFFD4AF37);
  static const Color olive = Color(0xFF556B2F);
  static const Color anthracite = Color(0xFF1C1C1C);
  static const Color cream = Color(0xFFFAF3E0);
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.ocre,
  scaffoldBackgroundColor: AppColors.cream,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.ocre,
    secondary: AppColors.gold,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.anthracite,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.ocre,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.anthracite),
    bodyLarge: TextStyle(fontSize: 14, color: AppColors.anthracite),
  ),
);
