import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';

/// Placeholder halaman 2. Hanya untuk membuktikan navigasi dan
/// state provider berjalan; akan diganti di tahap berikutnya.
class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<QuizProvider>().userName;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Mata Pelajaran',
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
                  'Halo, $userName',
                  style: textTheme.headlineMedium?.copyWith(
                    fontSize: context.sp(26),
                  ),
                ),
                SizedBox(height: context.s(8)),
                Text(
                  'Daftar mata pelajaran akan tampil di sini.',
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
