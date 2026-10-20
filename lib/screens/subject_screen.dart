import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/app_routes.dart';
import '../core/utils/responsive.dart';
import '../data/subject_data.dart';
import '../models/subject.dart';
import '../providers/quiz_provider.dart';
import '../widgets/greeting_header.dart';
import '../widgets/info_banner.dart';
import '../widgets/section_header.dart';
import '../widgets/subject_card.dart';

/// Halaman 2: memilih mata pelajaran.
///
/// StatelessWidget karena tidak punya state lokal; semua data
/// (nama, skor terakhir) dibaca dari QuizProvider.
class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  /// Jumlah kolom grid: HP potret 2, HP lanskap & tablet 3, desktop/web 4.
  int _columnCount(BuildContext context) {
    if (context.isDesktop) return 4;
    if (context.isTablet || context.isLandscape) return 3;
    return 2;
  }

  String _subtitleFor(QuizProvider quiz, Subject subject) {
    final score = quiz.lastScoreOf(subject.id);
    final status = score == null ? 'Belum dicoba' : 'Terakhir $score';
    return '$questionsPerQuiz soal · $status';
  }

  void _openQuiz(BuildContext context, Subject subject) {
    context.read<QuizProvider>().selectSubject(subject.id);
    Navigator.pushNamed(context, AppRoutes.quiz);
  }

  /// Kembali ke Halaman 1. Jika halaman ini dibuka tanpa riwayat
  /// (mis. lewat URL di web), ganti dengan halaman nama.
  void _editName(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushReplacementNamed(AppRoutes.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.s(12);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Padding samping minimal 20 (diskalakan); di layar lebar
            // padding membesar sehingga konten maks 1100 dan berada di tengah.
            final sidePadding = math.max(
              context.s(20),
              (constraints.maxWidth - Breakpoints.maxContentWidth) / 2,
            );

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    sidePadding,
                    context.s(16),
                    sidePadding,
                    context.s(14),
                  ),
                  sliver: SliverList.list(
                    children: [
                      GreetingHeader(
                        userName: quiz.userName,
                        onEditName: () => _editName(context),
                      ),
                      SizedBox(height: context.s(24)),
                      Semantics(
                        header: true,
                        child: Text(
                          'Mau belajar apa hari ini?',
                          style: textTheme.headlineMedium?.copyWith(
                            fontSize: context.sp(28),
                          ),
                        ),
                      ),
                      SizedBox(height: context.s(16)),
                      const InfoBanner(
                        icon: Icons.schedule_rounded,
                        text: 'Tiap kuis berisi $questionsPerQuiz soal. '
                            'Jawaban bisa kamu ubah sebelum kuis dikirim.',
                      ),
                      SizedBox(height: context.s(28)),
                      SectionHeader(
                        title: 'Mata Pelajaran',
                        trailing: '${subjects.length} pilihan',
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    sidePadding,
                    0,
                    sidePadding,
                    context.s(24),
                  ),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _columnCount(context),
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      // Tinggi kartu dihitung dari isinya, bukan rasio tetap.
                      mainAxisExtent: SubjectCard.extentOf(context),
                    ),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return SubjectCard(
                        subject: subject,
                        subtitle: _subtitleFor(quiz, subject),
                        onTap: () => _openQuiz(context, subject),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
