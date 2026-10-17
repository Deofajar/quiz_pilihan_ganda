import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';

/// Widget akar aplikasi: tema, mode terang/gelap, dan daftar route.
class KuisinApp extends StatelessWidget {
  const KuisinApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;

    return MaterialApp(
      title: 'Kuisin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}
