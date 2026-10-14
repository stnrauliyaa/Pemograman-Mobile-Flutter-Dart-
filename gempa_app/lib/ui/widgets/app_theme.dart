import 'package:flutter/material.dart';

/// Tema terang dan gelap aplikasi.
class AppTheme {
  AppTheme._();

  static final ThemeData light = _build(
    const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFE8590C),
      onPrimary: Colors.white,
      secondary: Color(0xFFFFB347),
      onSecondary: Color(0xFF3A2200),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF1C1B1F),
      surfaceContainerHighest: Color(0xFFF3EEE9),
      onSurfaceVariant: Color(0xFF6D6258),
      outlineVariant: Color(0xFFE8DFD6),
    ),
    const Color(0xFFFFF8F2),
  );

  static final ThemeData dark = _build(
    const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFF8A4C),
      onPrimary: Color(0xFF2B1200),
      secondary: Color(0xFFFFC46B),
      onSecondary: Color(0xFF2B1A00),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFF2B0000),
      surface: Color(0xFF151B2D),
      onSurface: Color(0xFFE8EAF2),
      surfaceContainerHighest: Color(0xFF1F2842),
      onSurfaceVariant: Color(0xFF9AA3BD),
      outlineVariant: Color(0xFF2A3354),
    ),
    const Color(0xFF0A0E1A),
  );

  static ThemeData _build(ColorScheme scheme, Color background) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
