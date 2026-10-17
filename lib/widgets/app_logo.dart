import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/app_assets.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/responsive.dart';

/// Logo aplikasi: ikon kotak + tulisan "Kuisin".
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Kuisin',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.logo,
            width: context.s(36),
            height: context.s(36),
          ),
          SizedBox(width: context.s(10)),
          Flexible(
            child: Text(
              'Kuisin',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTheme.headingFont,
                fontWeight: FontWeight.w800,
                fontSize: context.sp(22),
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
