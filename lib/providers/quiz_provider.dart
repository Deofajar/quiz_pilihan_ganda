import 'package:flutter/foundation.dart';

/// State kuis. Disimpan di atas MaterialApp sehingga tidak hilang
/// saat layar dirotasi atau berpindah halaman.
///
/// Untuk sekarang baru menyimpan nama pengguna; soal dan jawaban
/// ditambahkan di tahap berikutnya.
class QuizProvider extends ChangeNotifier {
  String _userName = '';

  String get userName => _userName;

  void setUserName(String name) {
    final trimmed = name.trim();
    if (trimmed == _userName) return;
    _userName = trimmed;
    notifyListeners();
  }
}
