import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00BFA5); // Emerald Green
  static const Color secondary = Color(0xFF2196F3); // Blue
  static const Color accent = Color(0xFFFF5252); // Coral Red
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
