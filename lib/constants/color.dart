import 'package:flutter/material.dart';

class AppColors {
  // ✅ Light Theme Colors
  static const Color blue = Color(0xFF009688);         // Teal
  static const Color red = Color(0xFFFFA000);          // Amber
  static const Color white = Color(0xFFFFFFFF);        // White
  static const Color whiteShade = Color(0xFFF1F8F7);   // Light Teal-Tint Background

  // Light mode dynamic colors
  static Color get blueLight => blue.withOpacity(0.2);
  static Color get redLight => red.withOpacity(0.2);
  static Color get blueTransparent => blue.withOpacity(0.5);
  static Color get redTransparent => red.withOpacity(0.5);

  // 🌙 Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);  // Classic dark background
  static const Color darkCard = Color(0xFF1E1E1E);         // Card surface
  static const Color darkSurface = Color(0xFF263238);      // Blue Grey shade
  static const Color darkWhite = Color(0xFFE0F2F1);        // Soft white with teal tint
  static const Color darkGrey = Color(0xFF90A4AE);         // Muted grey blue

  static const Color darkBlue = Color(0xFF80CBC4);         // Light Teal
  static const Color darkRed = Color(0xFFFFCC80);          // Light Amber
  static Color get darkBlueTransparent => darkBlue.withOpacity(0.5);
  static Color get darkRedTransparent => darkRed.withOpacity(0.5);
}
