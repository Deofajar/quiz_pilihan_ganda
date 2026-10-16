import 'package:flutter/material.dart';

/// Palet warna aplikasi. Semua warna di widget diambil dari sini
/// (atau dari Theme.of(context)), bukan ditulis langsung.
class AppColors {
  AppColors._();

  // Warna merek
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color secondary = Color(0xFF8B5CF6);

  // Warna status jawaban
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Mode terang
  static const Color backgroundLight = Color(0xFFF5F6FB);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF1E1B4B);
  static const Color textMutedLight = Color(0xFF64748B);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Mode gelap
  static const Color backgroundDark = Color(0xFF0F1020);
  static const Color surfaceDark = Color(0xFF1A1B2E);
  static const Color textDark = Color(0xFFEEF0FF);
  static const Color textMutedDark = Color(0xFFA0A3BD);
  static const Color borderDark = Color(0xFF2C2E45);
}
