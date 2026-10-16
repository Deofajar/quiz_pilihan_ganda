import 'package:flutter/material.dart';

/// Halaman awal. Untuk sementara masih placeholder;
/// form input nama dan pilihan kategori ditambahkan di bagian berikutnya.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Kuis Pilihan Ganda',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
