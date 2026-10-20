import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'icon_square_button.dart';

/// Tombol ganti tema: ikon bulan saat terang, matahari saat gelap.
/// Dipakai di Halaman 1 dan Halaman 2.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;

    return IconSquareButton(
      icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      tooltip: isDark ? 'Ganti ke mode terang' : 'Ganti ke mode gelap',
      onPressed: themeProvider.toggleTheme,
    );
  }
}
