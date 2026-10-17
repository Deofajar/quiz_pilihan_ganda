import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/app_assets.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Kartu berwarna berisi ilustrasi kuis.
/// Jika [height] null, kartu mengikuti tinggi dari parent-nya.
class HeroIllustration extends StatelessWidget {
  const HeroIllustration({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.all(context.s(16)),
      decoration: BoxDecoration(
        color: context.palette.heroCard,
        borderRadius: BorderRadius.circular(context.s(28)),
      ),
      child: SvgPicture.asset(
        AppAssets.heroQuiz,
        fit: BoxFit.contain,
        semanticsLabel: 'Ilustrasi kartu soal pilihan ganda',
      ),
    );
  }
}
