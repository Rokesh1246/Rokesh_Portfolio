import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette
  static const Color primaryDark = Color(0xFF0A0E1A);
  static const Color surfaceDark = Color(0xFF111827);
  static const Color cardDark = Color(0xFF1C2333);
  static const Color accentCyan = Color(0xFF00D4FF);
  static const Color accentPurple = Color(0xFF7C3AED);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color textPrimary = Color(0xFFF9FAFB);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color glassBorder = Color(0x1AFFFFFF);

  // Light Theme Colors
  static const Color lightBg = Color(0xFFF0F4FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF8FAFF);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: accentCyan,
        secondary: accentPurple,
        surface: surfaceDark,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      colorScheme: const ColorScheme.light(
        primary: accentPurple,
        secondary: accentCyan,
        surface: lightSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: lightTextPrimary,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.light().textTheme,
      ),
      useMaterial3: true,
    );
  }
}
