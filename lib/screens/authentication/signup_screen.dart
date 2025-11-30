import 'dart:io';

import 'package:finloop/screens/components/headers/auth_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../components/app_button.dart';
import '../components/app_field_label.dart';
import '../components/app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _showPasswordCriteria = false;

  bool _agreedToTerms = false;

  bool _passwordsMatch = true;
  bool _emailValid = true;

  bool _checkPlatform() => Platform.isIOS;

  final bool privacyStatus = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Map<String, bool> validatePassword(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigit = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacter = password.contains(RegExp(r'[^\w\s]'));
    bool isLengthValid = password.length >= 8;

    return {
      'isLengthValid': isLengthValid,
      'hasUppercase': hasUppercase,
      'hasLowercase': hasLowercase,
      'hasDigit': hasDigit,
      'hasSpecialCharacter': hasSpecialCharacter,
    };
  }

  bool validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  void _validateAndSubmit() {
    FocusScope.of(context).unfocus();
    setState(() {
      _emailValid = validateEmail(_emailController.text);
      _passwordsMatch = validateConfirmPassword(
        _passwordController.text,
        _confirmPasswordController.text,
      );
    });

    final passwordValidation = validatePassword(_passwordController.text);
    final isPasswordValid = passwordValidation.values.every(
      (element) => element == true,
    );

    if (_emailValid && _passwordsMatch && isPasswordValid) {
      if (privacyStatus && !_agreedToTerms) {
        return;
      }

      print("Validation Success: Ready to Register");
    } else {
      setState(() {
        _showPasswordCriteria = true;
      });
    }
  }

  Widget _buildValidationCriteria(String criteria, bool isValid) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            color: isValid ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              criteria,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isValid ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginRow(AppLocalizations l10n, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.signUpAlreadyHaveAccount,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
            child: Text(
              l10n.signIn,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final passwordValidation = validatePassword(_passwordController.text);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AuthHeader(leadingAction: false),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    AppFieldLabel(
                      text: l10n.signUpHelloMessage,
                      textStyle: theme.textTheme.headlineMedium,
                      color: theme.colorScheme.onSecondary,
                    ),
                    const SizedBox(height: 15),

                    AppFieldLabel(text: l10n.email),
                    AppTextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      hintText: l10n.enterEmailLabel,
                      showError: !_emailValid,
                      errorMessage: l10n.invalidEmailError,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        if (!_emailValid) {
                          setState(() => _emailValid = true);
                        }
                      },
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),

                    AppFieldLabel(text: l10n.password),
                    AppTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      hintText: l10n.enterPasswordLabel,
                      isPassword: true,
                      obscureText: !_passwordVisible,
                      onTogglePassword: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },

                      onChanged: (val) => setState(() {}),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        FocusScope.of(
                          context,
                        ).requestFocus(_confirmPasswordFocusNode);
                      },
                    ),

                    AppFieldLabel(text: l10n.signUpConfirmPassword),
                    AppTextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      hintText: l10n.signUpConfirmPassword,
                      isPassword: true,
                      obscureText: !_confirmPasswordVisible,
                      showError: !_passwordsMatch,
                      errorMessage: l10n.signUpPasswordMismatch,
                      onTogglePassword: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                      onChanged: (val) {
                        if (!_passwordsMatch) {
                          setState(() => _passwordsMatch = true);
                        }
                      },
                    ),

                    if (_showPasswordCriteria ||
                        _passwordController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildValidationCriteria(
                              l10n.signUpPasswordTooShort,
                              passwordValidation['isLengthValid']!,
                            ),
                            _buildValidationCriteria(
                              l10n.signUpPasswordNumber,
                              passwordValidation['hasDigit']!,
                            ),
                            _buildValidationCriteria(
                              l10n.signUpPasswordSpecialChar,
                              passwordValidation['hasSpecialCharacter']!,
                            ),
                            _buildValidationCriteria(
                              l10n.signUpPasswordUppercase,
                              passwordValidation['hasUppercase']!,
                            ),
                            _buildValidationCriteria(
                              l10n.signUpPasswordLowercase,
                              passwordValidation['hasLowercase']!,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),

                    if (privacyStatus)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _agreedToTerms,
                              activeColor: theme.colorScheme.primary,
                              onChanged: (value) {
                                setState(() {
                                  _agreedToTerms = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSecondary,
                                ),
                                children: [
                                  TextSpan(text: l10n.signUpBySigningUp),
                                  TextSpan(
                                    text: " ${l10n.signUpFinloop} ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: l10n.signUpAppAccountMessage),
                                  TextSpan(
                                    text: " ${l10n.signUpFinloop} ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: "${l10n.signUpApps} "),
                                  TextSpan(
                                    text: l10n.signUpTermsAndConditions,
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: Terms
                                      },
                                  ),
                                  TextSpan(text: " ${l10n.signUpAnd} "),
                                  TextSpan(
                                    text: l10n.signUpPrivacyPolicy,
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: Privacy
                                      },
                                  ),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 24),

                    AppButton(
                      text: l10n.signUpRegisterButton,
                      onPressed: _validateAndSubmit,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(color: theme.colorScheme.secondary),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              l10n.signUpOr,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: theme.colorScheme.secondary),
                          ),
                        ],
                      ),
                    ),

                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _buildSocialButton(
                            context,
                            Assets.googleLogo,
                            () {
                              // TODO: Google Sign In
                            },
                          ),
                        ),
                        SizedBox(width: _checkPlatform() ? 16 : 32),
                        Expanded(
                          flex: 1,
                          child: _buildSocialButton(
                            context,
                            Assets.facebookLogo,
                            () {
                              // TODO: Facebook Sign In
                            },
                          ),
                        ),
                        if (_checkPlatform()) const SizedBox(width: 16),
                        if (_checkPlatform())
                          Expanded(
                            flex: 1,
                            child: _buildSocialButton(
                              context,
                              Assets.appleLogo,
                              () {
                                // TODO: Apple Sign In
                              },
                              isApple: true,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _buildLoginRow(l10n, theme),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String asset,
    VoidCallback onTap, {
    bool isApple = false,
  }) {
    final theme = Theme.of(context);
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? const Color(0xFFF2F2F3)
            : const Color(0xFF191A1C),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE8ECF4), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: Image.asset(
            asset,
            width: 22,
            height: 22,
            color: isApple
                ? (theme.brightness == Brightness.light
                      ? Colors.black
                      : const Color(0xFF878787))
                : null,
          ),
        ),
      ),
    );
  }
}
