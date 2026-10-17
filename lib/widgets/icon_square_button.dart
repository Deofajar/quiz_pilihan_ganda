import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Tombol ikon berbentuk kotak bersudut (mis. toggle tema).
/// [tooltip] wajib diisi karena sekaligus menjadi label pembaca layar.
class IconSquareButton extends StatelessWidget {
  const IconSquareButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Area sentuh minimal 48 px sesuai pedoman aksesibilitas Material.
    final size = math.max(context.s(44), kMinInteractiveDimension);
    final radius = BorderRadius.circular(context.s(12));

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        excludeSemantics: true,
        child: Material(
          color: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: context.palette.border),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: radius,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: context.s(22),
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
