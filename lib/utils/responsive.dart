import 'package:flutter/widgets.dart';

/// Helper ukuran dinamis berdasarkan ukuran layar, supaya tidak ada
/// lebar/tinggi/jarak yang ditulis mati (hardcode) di widget.
///
/// Contoh: `SizedBox(height: context.sp(4))` = 4% dari sisi terpendek layar.
extension Responsive on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Sisi terpendek layar, dibatasi agar ukuran tidak membengkak di tablet/web.
  double get _base => screenSize.shortestSide.clamp(320.0, 600.0);

  /// Persentase dari lebar layar.
  double wp(double percent) => screenSize.width * percent / 100;

  /// Persentase dari tinggi layar.
  double hp(double percent) => screenSize.height * percent / 100;

  /// Persentase dari sisi terpendek layar; stabil saat layar dirotasi.
  double sp(double percent) => _base * percent / 100;

  bool get isTablet => screenSize.shortestSide >= 600;
  bool get isLandscape => screenSize.width > screenSize.height;
}
