import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';

/// Placeholder Halaman 3. Hanya untuk membuktikan navigasi dan
/// pilihan mapel tersimpan di provider; diganti di tahap berikutnya.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subject = context.watch<QuizProvider>().selectedSubject;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subject?.name ?? 'Kuis',
          style: textTheme.titleLarge?.copyWith(fontSize: context.sp(20)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.s(24)),
          child: MaxWidthBox(
            maxWidth: Breakpoints.maxFormWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Halaman soal (segera)',
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: context.sp(15),
                    color: context.palette.textMuted,
                  ),
                ),
                SizedBox(height: context.s(32)),
                PrimaryButton(
                  label: 'Kembali',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
