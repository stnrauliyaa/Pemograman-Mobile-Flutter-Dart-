import 'package:flutter/material.dart';

/// Warna sesuai tingkat kekuatan gempa.
Color magnitudeColor(double magnitude) {
  if (magnitude >= 6) return const Color(0xFFF0434A);
  if (magnitude >= 5) return const Color(0xFFFF8A1F);
  return const Color(0xFF2FBF71);
}

/// Label singkat tingkat kekuatan gempa.
String magnitudeLabel(double magnitude) {
  if (magnitude >= 6) return 'Kuat';
  if (magnitude >= 5) return 'Sedang';
  return 'Ringan';
}
