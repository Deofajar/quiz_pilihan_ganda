import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_text_field.dart';
import '../widgets/hero_illustration.dart';
import '../widgets/primary_button.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman 1: pengguna memasukkan nama sebelum memulai kuis.
///
/// StatefulWidget karena halaman ini punya state lokal:
/// controller teks, focus node, dan pesan error validasi.
class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  static const int maxNameLength = 20;
  static const int minNameLetters = 2;

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  late final TextEditingController _nameController;
  final FocusNode _nameFocus = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // Isi ulang dari provider supaya nama tidak hilang saat halaman dibuka lagi.
    _nameController = TextEditingController(
      text: context.read<QuizProvider>().userName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  /// Mengembalikan pesan error, atau null jika nama valid.
  String? _validate(String raw) {
    final name = raw.trim();
    if (name.isEmpty) return 'Nama tidak boleh kosong';

    final letterCount = RegExp(r'\p{L}', unicode: true).allMatches(name).length;
    if (letterCount < NameScreen.minNameLetters) return 'Nama minimal 2 huruf';

    if (name.length > NameScreen.maxNameLength) {
      return 'Nama maksimal 20 karakter';
    }
    return null;
  }

  /// Dipanggil oleh tombol "Mulai" dan tombol Done di keyboard.
  void _submit() {
    final error = _validate(_nameController.text);
    setState(() => _errorText = error);

    if (error != null) {
      _nameFocus.requestFocus();
      return;
    }

    context.read<QuizProvider>().setUserName(_nameController.text);
    FocusScope.of(context).unfocus();
    Navigator.pushNamed(context, AppRoutes.subject);
  }

  /// Hapus pesan error begitu pengguna mulai mengetik lagi.
  void _clearError(String _) {
    if (_errorText != null) setState(() => _errorText = null);
  }

  @override
  Widget build(BuildContext context) {
    final wide = context.useWideLayout;
    final horizontalPadding = context.s(wide ? 32 : 20);
    final verticalPadding = context.s(16);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = math.min(
              constraints.maxWidth - horizontalPadding * 2,
              Breakpoints.maxContentWidth,
            );

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: MaxWidthBox(
                // minHeight = tinggi layar, sehingga Spacer bisa mendorong
                // tombol ke bawah; saat keyboard muncul konten bisa di-scroll.
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: math.max(
                      0,
                      constraints.maxHeight - verticalPadding * 2,
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: wide
                        ? _buildWideLayout(context, contentWidth)
                        : _buildPortraitLayout(context),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// HP potret: satu kolom.
  Widget _buildPortraitLayout(BuildContext context) {
    final heroHeight =
        context.hp(32).clamp(context.s(180), context.s(300)).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Header(),
        SizedBox(height: context.s(20)),
        HeroIllustration(height: heroHeight),
        SizedBox(height: context.s(28)),
        _buildIntro(context),
        SizedBox(height: context.s(24)),
        _buildNameField(),
        const Spacer(),
        SizedBox(height: context.s(24)),
        _buildStartButton(),
      ],
    );
  }

  /// HP lanskap, tablet, dan web: ilustrasi di kiri, form di kanan.
  Widget _buildWideLayout(BuildContext context, double contentWidth) {
    final gap = context.s(32);
    // Lebar kolom form dihitung pasti (bukan Flexible) supaya
    // IntrinsicHeight mengukur tinggi teks pada lebar yang sama persis.
    final formWidth = math.min(
      Breakpoints.maxFormWidth,
      (contentWidth - gap) * 0.45,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Header(),
        SizedBox(height: context.s(24)),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ilustrasi mengisi sisa lebar dan seluruh tinggi baris.
              const Expanded(child: HeroIllustration()),
              SizedBox(width: gap),
              SizedBox(
                width: formWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildIntro(context),
                    SizedBox(height: context.s(24)),
                    _buildNameField(),
                    SizedBox(height: context.s(28)),
                    _buildStartButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIntro(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            'Uji pemahamanmu, satu soal sekali waktu.',
            style: textTheme.headlineMedium?.copyWith(
              fontSize: context.sp(30),
            ),
          ),
        ),
        SizedBox(height: context.s(10)),
        Text(
          'Pilih mata pelajaran, jawab 10 soal pilihan ganda, '
          'lalu lihat skormu di akhir.',
          style: textTheme.bodyLarge?.copyWith(
            fontSize: context.sp(15),
            color: context.palette.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return AppTextField(
      label: 'Nama kamu',
      controller: _nameController,
      focusNode: _nameFocus,
      hint: 'Contoh: Blessy',
      helperText: 'Namamu akan muncul di halaman skor akhir.',
      errorText: _errorText,
      prefixIcon: Icons.person_rounded,
      maxLength: NameScreen.maxNameLength,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.words,
      onChanged: _clearError,
      onSubmitted: (_) => _submit(),
    );
  }

  Widget _buildStartButton() {
    return PrimaryButton(
      label: 'Mulai',
      trailingIcon: Icons.arrow_forward_rounded,
      onPressed: _submit,
    );
  }
}

/// Baris atas: logo di kiri, tombol ganti tema di kanan.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Align(alignment: Alignment.centerLeft, child: AppLogo()),
        ),
        SizedBox(width: context.s(12)),
        const ThemeToggleButton(),
      ],
    );
  }
}
