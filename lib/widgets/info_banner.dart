import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Kotak informasi berwarna primary dengan ikon di kiri.
class InfoBanner extends StatelessWidget {
  const InfoBanner({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.s(16)),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(context.s(18)),
      ),
      child: Row(
        children: [
          ExcludeSemantics(
            child: Container(
              width: context.s(40),
              height: context.s(40),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(context.s(12)),
              ),
              child: Icon(
                icon,
                size: context.s(22),
                color: colorScheme.primary,
              ),
            ),
          ),
          SizedBox(width: context.s(12)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
