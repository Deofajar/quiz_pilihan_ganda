import 'package:flutter_test/flutter_test.dart';

import 'package:kuis_pilihan_ganda/app.dart';

void main() {
  testWidgets('Aplikasi tampil dengan halaman awal', (tester) async {
    await tester.pumpWidget(const KuisApp());

    expect(find.text('Kuis Pilihan Ganda'), findsOneWidget);
  });
}
