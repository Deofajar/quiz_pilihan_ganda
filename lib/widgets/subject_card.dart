import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/subject_colors.dart';
import '../core/utils/responsive.dart';
import '../models/subject.dart';

/// Kartu satu mata pelajaran di grid Halaman 2.
///
/// StatefulWidget karena kartu menyimpan state lokal: apakah sedang
/// ditekan, di-hover, atau difokus (untuk mengubah warna border).
class SubjectCard extends StatefulWidget {
  const SubjectCard({
    super.key,
    required this.subject,
    required this.subtitle,
    required this.onTap,
  });

  final Subject subject;
  final String subtitle;
  final VoidCallback onTap;

  // Tinggi baris teks (kelipatan ukuran font), dipakai juga di [extentOf].
  static const double _nameLineHeight = 1.25;
  static const double _subtitleLineHeight = 1.4;
  static const int _nameMaxLines = 2;

  /// Tinggi kartu untuk `mainAxisExtent` grid. Dihitung dari isi kartu
  /// (padding + ikon + 2 baris nama + subtitle) dan ikut skala teks sistem,
  /// sehingga nama 2 baris selalu muat.
  static double extentOf(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    final nameHeight = textScaler.scale(context.sp(16)) *
        _nameLineHeight *
        _nameMaxLines;
    final subtitleHeight =
        textScaler.scale(context.sp(12)) * _subtitleLineHeight;

    return context.s(16) * 2 + // padding atas + bawah
        context.s(48) + // kotak ikon
        context.s(14) + // jarak ikon ke nama
        nameHeight +
        context.s(4) + // jarak nama ke subtitle
        subtitleHeight +
        context.s(4); // sedikit ruang cadangan
  }

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  bool _pressed = false;
  bool _hovered = false;
  bool _focused = false;

  bool get _highlighted => _pressed || _hovered || _focused;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final palette = context.palette;
    final colors = context.subjectColors(widget.subject.colorKey);
    final radius = BorderRadius.circular(context.s(20));

    return Semantics(
      button: true,
      // Contoh: "Matematika, 10 soal, Belum dicoba".
      label: '${widget.subject.name}, '
          '${widget.subtitle.replaceAll(' · ', ', ')}',
      excludeSemantics: true,
      child: Material(
        color: colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: _highlighted ? colorScheme.primary : palette.border,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: (value) => setState(() => _pressed = value),
          onHover: (value) => setState(() => _hovered = value),
          onFocusChange: (value) => setState(() => _focused = value),
          child: Padding(
            padding: EdgeInsets.all(context.s(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.s(48),
                  height: context.s(48),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(context.s(14)),
                  ),
                  child: Icon(
                    widget.subject.icon,
                    size: context.s(26),
                    color: colors.icon,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.subject.name,
                  maxLines: SubjectCard._nameMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.sp(16),
                    fontWeight: FontWeight.w800,
                    height: SubjectCard._nameLineHeight,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: context.s(4)),
                Text(
                  widget.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.sp(12),
                    height: SubjectCard._subtitleLineHeight,
                    color: palette.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
