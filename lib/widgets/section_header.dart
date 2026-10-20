import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Judul bagian di kiri dan keterangan kecil di kanan.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: textTheme.titleLarge?.copyWith(fontSize: context.sp(18)),
            ),
          ),
        ),
        SizedBox(width: context.s(12)),
        Text(
          trailing,
          style: TextStyle(
            fontSize: context.sp(13),
            color: context.palette.textMuted,
          ),
        ),
      ],
    );
  }
}
