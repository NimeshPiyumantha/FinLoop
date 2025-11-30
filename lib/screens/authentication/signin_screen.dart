import 'dart:io';

import 'package:finloop/l10n/gen/app_localizations.dart';
import 'package:finloop/screens/components/headers/auth_header.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../components/app_button.dart';
import '../components/app_field_label.dart';
import '../components/app_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  bool _checkPlatform() => Platform.isIOS;

  bool _isLoginButtonClicked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _autoValidateMode = AutovalidateMode.disabled;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    void triggerAutoValidate() {
      if (_autoValidateMode != AutovalidateMode.onUserInteraction &&
          _isLoginButtonClicked) {
        setState(() {
          _autoValidateMode = AutovalidateMode.onUserInteraction;
        });
      }
    }

    Widget buildRegisterRow() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.signInDontHaveAccount,
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
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: Text(
                l10n.signInRegisterButton,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      );
    }

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
                      text: l10n.signInWelcomeBack,
                      textStyle: theme.textTheme.headlineMedium,
                      color: theme.colorScheme.onSecondary,
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      autovalidateMode: _autoValidateMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppFieldLabel(text: l10n.email),
                          AppTextField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            hintText: l10n.enterEmailLabel,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterEmail;
                              }
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(value)) {
                                return l10n.invalidEmailError;
                              }
                              return null;
                            },
                            onChanged: (_) => triggerAutoValidate(),
                            onSubmitted: (_) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_passwordFocusNode);
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.invalidPasswordError;
                              }
                              return null;
                            },
                            onChanged: (_) => triggerAutoValidate(),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgot_password");
                        },
                        child: AppFieldLabel(
                          text: l10n.forgotPassword,
                          color: theme.colorScheme.secondary,
                          textStyle: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      text: l10n.signIn,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _isLoginButtonClicked = true;
                        });

                        if (!_formKey.currentState!.validate()) {
                          setState(() {
                            _autoValidateMode =
                                AutovalidateMode.onUserInteraction;
                          });
                          return;
                        }

                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          return;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(color: theme.colorScheme.secondary),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              l10n.signInOr,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _buildSocialButton(
                            context,
                            Assets.googleLogo,
                            () {},
                          ),
                        ),
                        SizedBox(width: _checkPlatform() ? 16 : 32),
                        Expanded(
                          flex: 1,
                          child: _buildSocialButton(
                            context,
                            Assets.facebookLogo,
                            () {},
                          ),
                        ),
                        if (_checkPlatform()) const SizedBox(width: 16),
                        if (_checkPlatform())
                          Expanded(
                            flex: 1,
                            child: _buildSocialButton(
                              context,
                              Assets.appleLogo,
                              () {},
                              isApple: true,
                            ),
                          ),
                      ],
                    ),

                    buildRegisterRow(),
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
