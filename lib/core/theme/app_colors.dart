import 'package:flutter/material.dart';

class AppColors {
  // Purple Theme - Main Colors
  static const Color primaryPurple = Color(0xFF7C3AED); // Deep Purple
  static const Color secondaryPurple = Color(0xFFA855F7); // Purple
  static const Color accentPurple = Color(0xFF8B5CF6); // Violet
  static const Color lightPurple = Color(0xFFDDD6FE); // Light Purple
  static const Color palePurple = Color(0xFFF5F3FF); // Pale Purple
  
  // Background Colors
  static const Color background = Color(0xFFF5F3FF); // Light Purple Background
  static const Color cardBackground = Color(0xFFFFFFFF); // White
  static const Color surfaceBackground = Color(0xFFFAF9FC); // Off-white with purple tint
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A0B2E); // Deep Purple-Black
  static const Color textSecondary = Color(0xFF6B7280); // Gray
  static const Color textMuted = Color(0xFF9CA3AF); // Light Gray
  
  // Accent Colors
  static const Color success = Color(0xFF10B981); // Emerald Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue
  
  // Interactive Elements
  static const Color like = Color(0xFFEC4899); // Pink
  static const Color saved = Color(0xFF8B5CF6); // Violet
  static const Color rating = Color(0xFFFBBF24); // Yellow
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadows
  static final BoxShadow cardShadow = BoxShadow(
    color: primaryPurple.withOpacity(0.1),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
  
  static final BoxShadow buttonShadow = BoxShadow(
    color: primaryPurple.withOpacity(0.3),
    blurRadius: 12,
    offset: const Offset(0, 4),
  );
}
