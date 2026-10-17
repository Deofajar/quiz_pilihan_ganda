import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Kolom isian dengan label di atasnya, ikon di depan,
/// serta teks bantuan/error di bawahnya.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.maxLength,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;
  final String? helperText;

  /// Jika tidak null, field tampil dalam keadaan error.
  final String? errorText;
  final IconData? prefixIcon;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final palette = context.palette;
    final radius = BorderRadius.circular(context.s(14));

    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: color, width: width),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.sp(14),
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: context.s(8)),
        TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: maxLength,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.sp(16),
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            helperText: helperText,
            errorText: errorText,
            helperMaxLines: 2,
            errorMaxLines: 2,
            hintStyle: TextStyle(color: palette.textMuted),
            helperStyle: TextStyle(
              color: palette.textMuted,
              fontSize: context.sp(12),
            ),
            errorStyle: TextStyle(
              color: colorScheme.error,
              fontSize: context.sp(12),
            ),
            counterStyle: TextStyle(
              color: palette.textMuted,
              fontSize: context.sp(12),
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, size: context.s(22)),
            prefixIconColor: palette.textMuted,
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.s(16),
              vertical: context.s(16),
            ),
            enabledBorder: border(palette.border, context.s(1)),
            focusedBorder: border(colorScheme.primary, context.s(2)),
            errorBorder: border(colorScheme.error, context.s(1)),
            focusedErrorBorder: border(colorScheme.error, context.s(2)),
          ),
        ),
      ],
    );
  }
}
