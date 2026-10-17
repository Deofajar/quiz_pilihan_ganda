import 'package:flutter/material.dart';

/// Token warna mentah untuk mode terang dan gelap.
/// Widget tidak memakai kelas ini langsung, melainkan lewat
/// `Theme.of(context).colorScheme` atau `context.palette`.
class AppColors {
  AppColors._();

  // Mode terang
  static const Color lightBackground = Color(0xFFF3F5FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF14172B);
  static const Color lightTextMuted = Color(0xFF5A5F7A);
  static const Color lightBorder = Color(0xFFDCE0EE);
  static const Color lightPrimary = Color(0xFF3B3FD8);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFFE6E7FF);
  static const Color lightAccent = Color(0xFFFFB547);
  static const Color lightSuccess = Color(0xFF1C7A45);
  static const Color lightError = Color(0xFFC23B31);
  static const Color lightHeroCard = Color(0xFF3B3FD8);

  // Mode gelap
  static const Color darkBackground = Color(0xFF0F1222);
  static const Color darkSurface = Color(0xFF1A1E36);
  static const Color darkText = Color(0xFFEEF0FA);
  static const Color darkTextMuted = Color(0xFFA3A8C3);
  static const Color darkBorder = Color(0xFF2C3150);
  static const Color darkPrimary = Color(0xFF8B8FFF);
  static const Color darkOnPrimary = Color(0xFF0F1222);
  static const Color darkPrimaryContainer = Color(0xFF262A5A);
  static const Color darkAccent = Color(0xFFFFB547);
  static const Color darkSuccess = Color(0xFF4ADE80);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkHeroCard = Color(0xFF262A5A);
}

/// Warna yang tidak punya tempat di ColorScheme bawaan Flutter.
/// Disimpan sebagai ThemeExtension supaya ikut berganti saat tema diganti.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.textMuted,
    required this.border,
    required this.heroCard,
    required this.accent,
    required this.success,
  });

  final Color textMuted;
  final Color border;
  final Color heroCard;
  final Color accent;
  final Color success;

  static const AppPalette light = AppPalette(
    textMuted: AppColors.lightTextMuted,
    border: AppColors.lightBorder,
    heroCard: AppColors.lightHeroCard,
    accent: AppColors.lightAccent,
    success: AppColors.lightSuccess,
  );

  static const AppPalette dark = AppPalette(
    textMuted: AppColors.darkTextMuted,
    border: AppColors.darkBorder,
    heroCard: AppColors.darkHeroCard,
    accent: AppColors.darkAccent,
    success: AppColors.darkSuccess,
  );

  @override
  AppPalette copyWith({
    Color? textMuted,
    Color? border,
    Color? heroCard,
    Color? accent,
    Color? success,
  }) {
    return AppPalette(
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      heroCard: heroCard ?? this.heroCard,
      accent: accent ?? this.accent,
      success: success ?? this.success,
    );
  }

  /// Dipakai Flutter untuk animasi transisi warna saat tema berganti.
  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      heroCard: Color.lerp(heroCard, other.heroCard, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

/// Jalan pintas: `context.palette.textMuted`.
extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
