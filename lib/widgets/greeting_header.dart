import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'icon_square_button.dart';
import 'theme_toggle_button.dart';
import 'user_avatar.dart';

/// Baris sapaan: avatar, "Halo, {nama}", tombol ganti nama, dan toggle tema.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.userName,
    required this.onEditName,
  });

  final String userName;
  final VoidCallback onEditName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        UserAvatar(name: userName, size: context.s(48)),
        SizedBox(width: context.s(12)),
        // Expanded + ellipsis: nama panjang dipotong, tidak overflow.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Halo,',
                style: TextStyle(
                  fontSize: context.sp(13),
                  color: context.palette.textMuted,
                ),
              ),
              Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: context.sp(18),
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: context.s(8)),
        IconSquareButton(
          icon: Icons.edit_rounded,
          tooltip: 'Ganti nama',
          onPressed: onEditName,
        ),
        SizedBox(width: context.s(8)),
        const ThemeToggleButton(),
      ],
    );
  }
}
