import 'package:flutter/widgets.dart';

import '../../screens/name_screen.dart';
import '../../screens/quiz_screen.dart';
import '../../screens/subject_screen.dart';

/// Nama route (named route) dan pemetaannya ke halaman.
///
/// Catatan: saat splash screen ditambahkan, jadikan splash sebagai '/'
/// dan pindahkan halaman nama ke '/name'.
class AppRoutes {
  AppRoutes._();

  static const String initial = name;

  static const String name = '/';
  static const String subject = '/subject';
  static const String quiz = '/quiz';

  static Map<String, WidgetBuilder> get routes => {
        name: (_) => const NameScreen(),
        subject: (_) => const SubjectScreen(),
        quiz: (_) => const QuizScreen(),
      };
}
