import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    // Provider dipasang di atas MaterialApp agar state bertahan
    // saat rotasi layar maupun saat berpindah halaman.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: const KuisinApp(),
    ),
  );
}
