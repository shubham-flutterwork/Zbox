import 'package:flutter/material.dart';

class AppColors {
  // ✅ Light Theme (finalized)
  static const Color blue = Color(0xFF1565C0); // blue
  static const Color red = Color(0xFFD32F2F);  // red
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteShade = Color(0xFFF5F5F5);

  // Light mode dynamic colors (computed on demand)
  static Color get blueLight => blue.withOpacity(0.2);
  static Color get redLight => red.withOpacity(0.2);
  static Color get blueTransparent => blue.withOpacity(0.5);
  static Color get redTransparent => red.withOpacity(0.5);

  // 🌙 Dark Theme Additions
  static const Color darkBackground = Color(0xFF847F7F);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF2C2C2C);
  static const Color darkWhite = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF888888);

  static const Color darkBlue = Color(0xFF5C9EFF);
  static const Color darkRed = Color(0xFFFF6B6B);
  static Color get darkBlueTransparent => darkBlue.withOpacity(0.5);
  static Color get darkRedTransparent => darkRed.withOpacity(0.5);
}
