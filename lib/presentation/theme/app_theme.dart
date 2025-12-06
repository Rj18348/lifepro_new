import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// Theme provider moved here so theme tokens and state live in one file.
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setMode(ThemeMode mode) {
    state = mode;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

/// Centralized application color tokens and ThemeData.
class AppColors {
  // Pastel, soft palette inspired by the provided reference
  static const Color primary = Color(0xFF7FD3C9); // soft mint
  static const Color secondary = Color(0xFFF3C6E0); // pastel pink
  static const Color accent = Color(0xFFD7C8F6); // soft lavender
  static const Color deepTeal = Color(0xFF1F6B6B); // deeper teal for contrast

  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color scaffoldLight = Color(0xFFEDF6F6); // very light aqua
  static const Color cardTint = Color(
    0xFFF8F6FB,
  ); // subtle pink/cream tint for cards
  static const Color darkSurface = Color(0xFF0F1720);
  static const Color scaffoldDark = darkSurface;
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      surface: AppColors.lightSurface,
      secondary: AppColors.secondary,
      primaryContainer: AppColors.primary,
      secondaryContainer: AppColors.secondary,
    ),
    textTheme: GoogleFonts.outfitTextTheme(),
    scaffoldBackgroundColor: AppColors.scaffoldLight,
    // small elevated card style with soft tint
    cardColor: AppColors.cardTint,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.darkSurface,
      secondary: AppColors.secondary,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: AppColors.scaffoldDark,
    cardColor: Colors.grey.shade900,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
