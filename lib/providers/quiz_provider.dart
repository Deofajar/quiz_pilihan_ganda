import 'package:flutter/foundation.dart';

import '../data/subject_data.dart';
import '../models/subject.dart';

/// State kuis. Disimpan di atas MaterialApp sehingga tidak hilang
/// saat layar dirotasi atau berpindah halaman.
///
/// Saat ini menyimpan nama pengguna, mapel yang dipilih, dan skor
/// terakhir per mapel; soal dan jawaban ditambahkan di tahap berikutnya.
class QuizProvider extends ChangeNotifier {
  String _userName = '';
  String? _selectedSubjectId;

  /// Skor terakhir per mapel (0–100), kunci = id mapel.
  final Map<String, int> _lastScores = {};

  String get userName => _userName;

  void setUserName(String name) {
    final trimmed = name.trim();
    if (trimmed == _userName) return;
    _userName = trimmed;
    notifyListeners();
  }

  // ---------- Mata pelajaran ----------

  String? get selectedSubjectId => _selectedSubjectId;

  /// Objek mapel yang sedang dipilih, atau null jika belum ada.
  Subject? get selectedSubject {
    for (final subject in subjects) {
      if (subject.id == _selectedSubjectId) return subject;
    }
    return null;
  }

  void selectSubject(String subjectId) {
    _selectedSubjectId = subjectId;
    // TODO: di sesi berikutnya, method ini juga me-reset jawaban kuis
    // supaya setiap kali memilih mapel, kuis dimulai dari awal.
    notifyListeners();
  }

  // ---------- Skor ----------

  /// Salinan read-only agar map tidak diubah dari luar provider.
  Map<String, int> get lastScores => Map.unmodifiable(_lastScores);

  int? lastScoreOf(String subjectId) => _lastScores[subjectId];

  /// Simpan skor terakhir sebuah mapel (dipakai halaman hasil nanti).
  void setLastScore(String subjectId, int score) {
    _lastScores[subjectId] = score.clamp(0, 100);
    notifyListeners();
  }
}
