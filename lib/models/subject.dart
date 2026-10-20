import 'package:flutter/widgets.dart';

/// Kunci warna tiap mata pelajaran. Warna aslinya diatur di
/// `core/theme/subject_colors.dart` agar bisa beda di mode terang/gelap.
enum SubjectColor {
  matematika,
  fisika,
  biologi,
  sejarah,
  bahasaInggris,
  pengetahuanUmum,
}

/// Data satu mata pelajaran. Immutable: semua field final
/// dan constructor const, jadi bisa dipakai di daftar `const`.
@immutable
class Subject {
  const Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.colorKey,
  });

  final String id;
  final String name;
  final IconData icon;
  final SubjectColor colorKey;
}
