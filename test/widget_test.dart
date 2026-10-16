import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kuis_pilihan_ganda/app.dart';
import 'package:kuis_pilihan_ganda/theme/app_theme.dart';

void main() {
  testWidgets('Aplikasi tampil dengan halaman awal', (tester) async {
    await tester.pumpWidget(const KuisApp());

    expect(find.text('Kuis Pilihan Ganda'), findsOneWidget);
  });

  test('Tema terang dan gelap memakai font Poppins', () {
    expect(AppTheme.light.textTheme.bodyMedium?.fontFamily, 'Poppins');
    expect(AppTheme.dark.textTheme.bodyMedium?.fontFamily, 'Poppins');
    expect(AppTheme.light.brightness, Brightness.light);
    expect(AppTheme.dark.brightness, Brightness.dark);
  });
}
