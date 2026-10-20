import 'package:flutter/material.dart';

import '../../models/subject.dart';

/// Pasangan warna untuk kotak ikon mata pelajaran.
@immutable
class SubjectColorPair {
  const SubjectColorPair({required this.background, required this.icon});

  final Color background;
  final Color icon;
}

/// Warna per mata pelajaran untuk mode terang.
const Map<SubjectColor, SubjectColorPair> _lightColors = {
  SubjectColor.matematika: SubjectColorPair(
    background: Color(0xFFE6E7FF),
    icon: Color(0xFF3B3FD8),
  ),
  SubjectColor.fisika: SubjectColorPair(
    background: Color(0xFFFFF0D9),
    icon: Color(0xFFA3560A),
  ),
  SubjectColor.biologi: SubjectColorPair(
    background: Color(0xFFDDF4E6),
    icon: Color(0xFF1C7A45),
  ),
  SubjectColor.sejarah: SubjectColorPair(
    background: Color(0xFFFBE3DF),
    icon: Color(0xFFA8352A),
  ),
  SubjectColor.bahasaInggris: SubjectColorPair(
    background: Color(0xFFE0F0FB),
    icon: Color(0xFF1D6A9E),
  ),
  SubjectColor.pengetahuanUmum: SubjectColorPair(
    background: Color(0xFFF1E6FB),
    icon: Color(0xFF7A3BB0),
  ),
};

/// Warna per mata pelajaran untuk mode gelap.
const Map<SubjectColor, SubjectColorPair> _darkColors = {
  SubjectColor.matematika: SubjectColorPair(
    background: Color(0xFF262A5A),
    icon: Color(0xFFB9BCFF),
  ),
  SubjectColor.fisika: SubjectColorPair(
    background: Color(0xFF3A2A12),
    icon: Color(0xFFFFC37A),
  ),
  SubjectColor.biologi: SubjectColorPair(
    background: Color(0xFF14321F),
    icon: Color(0xFF6EE7A0),
  ),
  SubjectColor.sejarah: SubjectColorPair(
    background: Color(0xFF3A1C18),
    icon: Color(0xFFFF9C8F),
  ),
  SubjectColor.bahasaInggris: SubjectColorPair(
    background: Color(0xFF13293A),
    icon: Color(0xFF7CC4F5),
  ),
  SubjectColor.pengetahuanUmum: SubjectColorPair(
    background: Color(0xFF2C1E3D),
    icon: Color(0xFFD3B0F5),
  ),
};

/// Ambil pasangan warna sesuai mapel dan tema yang sedang aktif.
SubjectColorPair subjectColorsOf(SubjectColor key, Brightness brightness) {
  final table = brightness == Brightness.dark ? _darkColors : _lightColors;
  return table[key]!;
}

/// Jalan pintas: `context.subjectColors(subject.colorKey)`.
extension SubjectColorsContext on BuildContext {
  SubjectColorPair subjectColors(SubjectColor key) =>
      subjectColorsOf(key, Theme.of(this).brightness);
}
