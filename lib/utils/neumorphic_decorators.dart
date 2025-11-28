import 'package:flutter/material.dart';

InputDecoration getNeumorphicInputDecoration({
  required BuildContext context,
  required String hintText,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return InputDecoration(
    filled: true,
    fillColor: colorScheme.surface, // Must match background
    hintText: hintText,
    hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 20.0,
    ),
    // Remove standard borders
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    // We use a PrefixIcon or Container to simulate the inner shadow if the
    // library isn't available, but optimally we wrap the TextField in a
    // Neumorphic container with depth: -4 (negative depth).
  );
}
