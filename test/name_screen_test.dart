import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:kuis_pilihan_ganda/app.dart';
import 'package:kuis_pilihan_ganda/providers/quiz_provider.dart';
import 'package:kuis_pilihan_ganda/providers/theme_provider.dart';
import 'package:kuis_pilihan_ganda/screens/subject_screen.dart';

/// Susunan yang sama dengan main.dart.
Widget buildApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => QuizProvider()),
    ],
    child: const KuisinApp(),
  );
}

/// Atur ukuran layar uji (dalam logical pixel).
void setScreenSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets(
    'Nama kosong menampilkan error, nama valid pindah ke halaman subject',
    (tester) async {
      setScreenSize(tester, const Size(390, 844));
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // Submit tanpa nama -> error tampil di field, tetap di halaman nama.
      await tester.tap(find.text('Mulai'));
      await tester.pump();
      expect(find.text('Nama tidak boleh kosong'), findsOneWidget);
      expect(find.byType(SubjectScreen), findsNothing);

      // Nama valid -> pindah ke halaman subject dan nama tersimpan.
      await tester.enterText(find.byType(TextField), '  Blessy ');
      await tester.tap(find.text('Mulai'));
      await tester.pumpAndSettle();
      expect(find.byType(SubjectScreen), findsOneWidget);
      final quiz =
          tester.element(find.byType(SubjectScreen)).read<QuizProvider>();
      expect(quiz.userName, 'Blessy');
      expect(find.text('Blessy'), findsOneWidget);
    },
  );

  // Kriteria 8: tidak ada overflow di berbagai ukuran layar.
  const sizes = {
    'HP kecil': Size(320, 568),
    'HP potret': Size(390, 844),
    'HP lanskap': Size(844, 390),
    'Tablet': Size(820, 1180),
    'Web/desktop': Size(1440, 900),
  };

  for (final entry in sizes.entries) {
    for (final textScale in [1.0, 1.3, 2.0]) {
      testWidgets('Tanpa overflow: ${entry.key}, teks ${textScale}x',
          (tester) async {
        setScreenSize(tester, entry.value);
        tester.platformDispatcher.textScaleFactorTestValue = textScale;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        await tester.pumpWidget(buildApp());
        await tester.pumpAndSettle();

        // Tampilkan juga pesan error agar field dalam kondisi terpanjang.
        await tester.ensureVisible(find.text('Mulai'));
        await tester.tap(find.text('Mulai'));
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });
    }
  }
}
