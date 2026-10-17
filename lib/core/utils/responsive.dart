import 'package:flutter/widgets.dart';

/// Batas-batas layout. Semua angka "aturan layout" dikumpulkan di sini.
class Breakpoints {
  Breakpoints._();

  /// Lebar layar acuan desain (HP ukuran umum).
  static const double designWidth = 390;

  /// Lebar mulai dianggap tablet.
  static const double tablet = 600;

  /// Lebar mulai dianggap desktop/web lebar.
  static const double desktop = 1024;

  /// Lebar maksimum seluruh konten supaya tidak melebar di web.
  static const double maxContentWidth = 1100;

  /// Lebar maksimum kolom form pada layout dua kolom.
  static const double maxFormWidth = 440;

  /// Batas faktor skala agar ukuran tidak terlalu kecil/besar.
  static const double minScale = 0.85;
  static const double maxScale = 1.35;
}

/// Helper ukuran dinamis. Angka desain (dibuat untuk layar 390 px)
/// dikalikan faktor skala, sehingga ukuran menyesuaikan layar.
///
/// Contoh: `context.s(24)` untuk jarak/ukuran, `context.sp(16)` untuk font.
extension Responsive on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Faktor skala = sisi terpendek / 390, dibatasi 0.85–1.35.
  /// Memakai sisi terpendek supaya ukuran tidak melompat saat dirotasi.
  double get scale => (screenSize.shortestSide / Breakpoints.designWidth)
      .clamp(Breakpoints.minScale, Breakpoints.maxScale);

  /// Ukuran/jarak (padding, tinggi, radius, ikon).
  double s(double value) => value * scale;

  /// Ukuran font.
  double sp(double value) => value * scale;

  /// Persentase dari tinggi layar, misal `context.hp(32)` = 32% tinggi.
  double hp(double percent) => screenHeight * percent / 100;

  bool get isMobile => screenWidth < Breakpoints.tablet;
  bool get isTablet =>
      screenWidth >= Breakpoints.tablet && screenWidth < Breakpoints.desktop;
  bool get isDesktop => screenWidth >= Breakpoints.desktop;
  bool get isLandscape => screenWidth > screenHeight;

  /// Layout dua kolom dipakai di tablet/web atau saat HP dimiringkan.
  bool get useWideLayout => !isMobile || isLandscape;
}

/// Membatasi lebar konten dan menaruhnya di tengah layar.
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.maxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
