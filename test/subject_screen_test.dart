import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:kuis_pilihan_ganda/app.dart';
import 'package:kuis_pilihan_ganda/core/routes/app_routes.dart';
import 'package:kuis_pilihan_ganda/providers/quiz_provider.dart';
import 'package:kuis_pilihan_ganda/providers/theme_provider.dart';
import 'package:kuis_pilihan_ganda/screens/quiz_screen.dart';
import 'package:kuis_pilihan_ganda/widgets/subject_card.dart';

/// Atur ukuran layar uji (dalam logical pixel).
void setScreenSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

/// Jalankan aplikasi dengan [quiz] yang sudah disiapkan, lalu buka
/// Halaman 2 di atas Halaman 1 (sama seperti alur aslinya).
Future<void> openSubjectScreen(WidgetTester tester, QuizProvider quiz) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: quiz),
      ],
      child: const KuisinApp(),
    ),
  );
  await tester.pumpAndSettle();
  tester.state<NavigatorState>(find.byType(Navigator)).pushNamed(
        AppRoutes.subject,
      );
  await tester.pumpAndSettle();
}

/// Scroll sampai bawah supaya semua kartu ikut di-layout.
Future<void> scrollToBottom(WidgetTester tester) async {
  await tester.drag(find.byType(CustomScrollView), const Offset(0, -2000));
  await tester.pumpAndSettle();
}

void main() {
  late QuizProvider quiz;

  setUp(() {
    quiz = QuizProvider()..setUserName('Blessy');
  });

  testWidgets('Menampilkan 6 kartu mapel dan nama dari provider',
      (tester) async {
    setScreenSize(tester, const Size(412, 1200));
    await openSubjectScreen(tester, quiz);

    expect(find.byType(SubjectCard), findsNWidgets(6));
    expect(find.text('Blessy'), findsOneWidget);
    expect(find.text('10 soal · Belum dicoba'), findsNWidgets(6));
  });

  testWidgets('Tap Biologi memilih mapel dan membuka halaman soal',
      (tester) async {
    setScreenSize(tester, const Size(390, 844));
    await openSubjectScreen(tester, quiz);

    await tester.ensureVisible(find.text('Biologi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Biologi'));
    await tester.pumpAndSettle();

    expect(quiz.selectedSubjectId, 'biologi');
    expect(find.byType(QuizScreen), findsOneWidget);
  });

  testWidgets('Subtitle menampilkan skor terakhir dari provider',
      (tester) async {
    quiz.setLastScore('matematika', 80);
    setScreenSize(tester, const Size(390, 844));
    await openSubjectScreen(tester, quiz);

    expect(find.text('10 soal · Terakhir 80'), findsOneWidget);
    expect(find.text('10 soal · Belum dicoba'), findsWidgets);
  });

  testWidgets('Ganti nama kembali ke Halaman 1', (tester) async {
    setScreenSize(tester, const Size(390, 844));
    await openSubjectScreen(tester, quiz);

    await tester.tap(find.byTooltip('Ganti nama'));
    await tester.pumpAndSettle();

    expect(find.text('Mulai'), findsOneWidget);
  });

  // Tidak ada overflow di HP potret & lanskap, tablet, dan web,
  // untuk teks normal maupun diperbesar, di mode terang dan gelap.
  const sizes = {
    'HP 360x640': Size(360, 640),
    'HP 640x360': Size(640, 360),
    'Tablet': Size(820, 1180),
    'Web/desktop': Size(1440, 900),
  };

  for (final entry in sizes.entries) {
    for (final textScale in [1.0, 2.0]) {
      for (final dark in [false, true]) {
        final mode = dark ? 'gelap' : 'terang';
        testWidgets(
            'Tanpa overflow: ${entry.key}, teks ${textScale}x, mode $mode',
            (tester) async {
          setScreenSize(tester, entry.value);
          tester.platformDispatcher.textScaleFactorTestValue = textScale;
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          quiz.setUserName('Nama Yang Sangat Panjang Sekali');
          quiz.setLastScore('fisika', 100);

          await openSubjectScreen(tester, quiz);
          if (dark) {
            await tester.tap(find.byTooltip('Ganti ke mode gelap'));
            await tester.pumpAndSettle();
          }
          await scrollToBottom(tester);

          expect(tester.takeException(), isNull);
        });
      }
    }
  }
}
