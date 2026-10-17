import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../core/utils/responsive.dart';

/// Tombol utama selebar parent. Jika [onPressed] null, tombol nonaktif.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.trailingIcon,
  });

  final String label;
  final VoidCallback? onPressed;

  /// Ikon opsional yang tampil setelah teks.
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: math.max(context.s(56), kMinInteractiveDimension),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: context.s(20)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.s(16)),
          ),
          textStyle: TextStyle(
            fontFamily: AppTheme.bodyFont,
            fontWeight: FontWeight.w700,
            fontSize: context.sp(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            if (trailingIcon != null) ...[
              SizedBox(width: context.s(8)),
              Icon(trailingIcon, size: context.s(20)),
            ],
          ],
        ),
      ),
    );
  }
}
