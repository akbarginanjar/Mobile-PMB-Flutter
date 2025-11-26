import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Color primary = HexColor('#1A75BB');
Color secondary = HexColor('#38B349');
Color success = HexColor('#00b300');
Color danger = HexColor('#cc0000');
Color warning = HexColor('#FFCA00');
Color info = HexColor('#1992ff');

ThemeData defaultTheme(BuildContext context) {
  return ThemeData(
    // General colors
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.white,
    // Text theme (tweak as needed)
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14),
    ),
    // Input theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: TextStyle(color: Colors.grey.shade500),
      // default border (disabled / enabled)
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1),
      ),
      // when focused -> orange border
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primary, width: 2),
      ),
      // error style small radius
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
      ),
    ),
    // Elevated button theme (rounded orange)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
