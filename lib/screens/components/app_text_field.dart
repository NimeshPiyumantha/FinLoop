import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onTogglePassword;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputAction textInputAction;
  final bool showError;
  final String? errorMessage;
  final Color? lightFillColor;
  final Color? darkFillColor;

  const AppTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.isPassword = false,
    this.obscureText = false,
    this.onTogglePassword,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
    this.showError = false,
    this.errorMessage,
    this.lightFillColor,
    this.darkFillColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword ? obscureText : false,
        validator: validator,
        onChanged: onChanged,
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmitted,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSecondary,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle: const TextStyle(color: Color(0xFF848484), fontSize: 16),
          fillColor: isLight
              ? (lightFillColor ?? const Color(0xFFF2F2F3))
              : (darkFillColor ?? const Color(0xFF191A1C)),
          filled: true,
          errorText: showError ? errorMessage : null,
          errorStyle: const TextStyle(color: Color(0xFFB00020), fontSize: 16),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: const Color(0xFFB00020), width: 1.5),
          ),
          helperText: showError ? null : " ",
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF848484),
                  ),
                  onPressed: onTogglePassword,
                )
              : const SizedBox.shrink(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isLight ? const Color(0xFFF2F2F3) : const Color(0xFF191A1C),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isLight ? const Color(0xFFF2F2F3) : const Color(0xFF191A1C),
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isLight ? const Color(0xFFF2F2F3) : const Color(0xFF191A1C),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
