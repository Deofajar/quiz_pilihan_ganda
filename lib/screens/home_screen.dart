import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_assets.dart';
import '../utils/responsive.dart';

/// Halaman awal. Untuk sementara menampilkan logo dan judul;
/// form input nama dan pilihan kategori ditambahkan di bagian berikutnya.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.sp(6)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.logo,
                  width: context.sp(28),
                  semanticsLabel: 'Logo Kuis Pilihan Ganda',
                ),
                SizedBox(height: context.sp(5)),
                Text(
                  'Kuis Pilihan Ganda',
                  style: textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.sp(2)),
                Text(
                  'Uji pengetahuanmu dan lihat seberapa jago kamu!',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
