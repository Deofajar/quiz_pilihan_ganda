import 'package:flutter/material.dart';

import '../models/subject.dart';

/// Daftar mata pelajaran (data lokal, tanpa database).
const List<Subject> subjects = [
  Subject(
    id: 'matematika',
    name: 'Matematika',
    icon: Icons.calculate_rounded,
    colorKey: SubjectColor.matematika,
  ),
  Subject(
    id: 'fisika',
    name: 'Fisika',
    icon: Icons.science_rounded,
    colorKey: SubjectColor.fisika,
  ),
  Subject(
    id: 'biologi',
    name: 'Biologi',
    icon: Icons.eco_rounded,
    colorKey: SubjectColor.biologi,
  ),
  Subject(
    id: 'sejarah',
    name: 'Sejarah',
    icon: Icons.account_balance_rounded,
    colorKey: SubjectColor.sejarah,
  ),
  Subject(
    id: 'bahasa_inggris',
    name: 'Bahasa Inggris',
    icon: Icons.translate_rounded,
    colorKey: SubjectColor.bahasaInggris,
  ),
  Subject(
    id: 'pengetahuan_umum',
    name: 'Pengetahuan Umum',
    icon: Icons.lightbulb_rounded,
    colorKey: SubjectColor.pengetahuanUmum,
  ),
];
