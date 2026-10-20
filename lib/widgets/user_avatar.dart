import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

/// Lingkaran berisi huruf pertama nama pengguna.
/// [size] sebaiknya dihitung lewat helper responsif, mis. `context.s(48)`.
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.name, required this.size});

  final String name;
  final double size;

  /// Perbandingan ukuran huruf terhadap diameter lingkaran.
  static const double _letterRatio = 0.45;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final trimmed = name.trim();
    final initial =
        trimmed.isEmpty ? '?' : trimmed.characters.first.toUpperCase();

    // Dekoratif saja; nama sudah dibacakan oleh teks di sebelahnya.
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // secondary = accent (#FFB547), onSecondary = #14172B di kedua tema.
          color: colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        child: Text(
          initial,
          // Ukuran huruf mengikuti diameter, tidak ikut skala teks sistem
          // supaya hurufnya tidak keluar dari lingkaran.
          textScaler: TextScaler.noScaling,
          style: TextStyle(
            fontFamily: AppTheme.headingFont,
            fontWeight: FontWeight.w800,
            fontSize: size * _letterRatio,
            color: colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
