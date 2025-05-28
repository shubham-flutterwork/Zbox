import 'package:flutter/material.dart';

class AppColors {
  static const Color blue = Color(0xFF1565C0); // blue
  static const Color red = Color(0xFFD32F2F);  // red
  static const Color white = Color(0xFFFFFFFF);// white
  static const whiteShade = Color(0xFFF5F5F5);

  // shades using opacity
  static Color blueLight = blue.withOpacity(0.2);
  static Color redLight = red.withOpacity(0.2);
  static Color blueTransparent = blue.withOpacity(0.5);
  static Color redTransparent = red.withOpacity(0.5);
}
