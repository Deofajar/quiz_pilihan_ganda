import 'package:flutter/material.dart';

import 'app_colors.dart';

/// ThemeData terang dan gelap.
///
/// Ukuran font sengaja tidak ditetapkan di sini; widget mengaturnya
/// lewat helper responsif (`context.sp(...)`) supaya ikut ukuran layar.
class AppTheme {
  AppTheme._();

  /// Font teks isi.
  static const String bodyFont = 'PlusJakartaSans';

  /// Font judul.
  static const String headingFont = 'BricolageGrotesque';

  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        text: AppColors.lightText,
        primary: AppColors.lightPrimary,
        onPrimary: AppColors.lightOnPrimary,
        primaryContainer: AppColors.lightPrimaryContainer,
        error: AppColors.lightError,
        palette: AppPalette.light,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        text: AppColors.darkText,
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkOnPrimary,
        primaryContainer: AppColors.darkPrimaryContainer,
        error: AppColors.darkError,
        palette: AppPalette.dark,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color text,
    required Color primary,
    required Color onPrimary,
    required Color primaryContainer,
    required Color error,
    required AppPalette palette,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    ).copyWith(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: text,
      secondary: palette.accent,
      onSecondary: AppColors.lightText,
      error: error,
      onError: surface,
      surface: surface,
      onSurface: text,
      onSurfaceVariant: palette.textMuted,
      outline: palette.border,
      outlineVariant: palette.border,
    );

    // Semua teks memakai Plus Jakarta Sans; gaya judul memakai Bricolage.
    final baseText = ThemeData(brightness: brightness)
        .textTheme
        .apply(fontFamily: bodyFont, bodyColor: text, displayColor: text);

    TextStyle? heading(TextStyle? style) => style?.copyWith(
          fontFamily: headingFont,
          fontWeight: FontWeight.w800,
          height: 1.15,
        );

    final textTheme = baseText.copyWith(
      displayLarge: heading(baseText.displayLarge),
      displayMedium: heading(baseText.displayMedium),
      displaySmall: heading(baseText.displaySmall),
      headlineLarge: heading(baseText.headlineLarge),
      headlineMedium: heading(baseText.headlineMedium),
      headlineSmall: heading(baseText.headlineSmall),
      titleLarge: baseText.titleLarge?.copyWith(
        fontFamily: headingFont,
        fontWeight: FontWeight.w700,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      fontFamily: bodyFont,
      textTheme: textTheme,
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: background,
        foregroundColor: text,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge,
      ),
    );
  }
}
