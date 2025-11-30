import 'package:finloop/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../screens/components/app_button.dart';
import '../../screens/components/app_field_label.dart';
import '../../screens/components/app_text_field.dart';
import '../components/headers/auth_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool isChangePassword;

  const ForgotPasswordScreen({super.key, this.isChangePassword = false});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _emailValid = true;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _submit() {
    setState(() {
      _emailValid = validateEmail(_emailController.text);
    });

    if (_emailValid && _emailController.text.isNotEmpty) {
      print('Sending link to: ${_emailController.text}');
    } else if (_emailController.text.isEmpty) {
      setState(() {
        _emailValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AuthHeader(
          leadingAction: true,
          triggerFunction: () {
            Navigator.of(context).pop();
          },
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    AppFieldLabel(
                      text: widget.isChangePassword
                          ? l10n.changePasswordTitle
                          : l10n.forgotPassword,
                      textStyle: theme.textTheme.headlineMedium,
                      color: theme.colorScheme.onSecondary,
                    ),
                    const SizedBox(height: 10),

                    Text(
                      widget.isChangePassword
                          ? l10n.changePasswordDesc
                          : l10n.forgotPasswordDesc,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 30),

                    AppFieldLabel(text: l10n.enterEmailLabel),
                    AppTextField(
                      controller: _emailController,
                      hintText: l10n.enterEmailLabel,
                      showError: !_emailValid,
                      errorMessage: l10n.invalidEmailError,
                      onChanged: (val) {
                        if (!_emailValid) {
                          setState(() {
                            _emailValid = true;
                          });
                        }
                      },
                      onSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: 30),

                    AppButton(text: l10n.sendLinkButton, onPressed: _submit),
                    const SizedBox(height: 30),

                    if (!widget.isChangePassword)
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.rememberPassword,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSecondary,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                l10n.signIn,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}