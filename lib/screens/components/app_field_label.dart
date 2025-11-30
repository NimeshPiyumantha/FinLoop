import 'package:flutter/material.dart';

class AppFieldLabel extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  const AppFieldLabel({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: (textStyle ?? theme.textTheme.titleMedium)?.copyWith(
          color: color ?? theme.colorScheme.onSecondary,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
