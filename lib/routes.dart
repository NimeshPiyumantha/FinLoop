import 'package:finloop/screens/authentication/forgot_password.dart';
import 'package:finloop/screens/authentication/signin_screen.dart';
import 'package:finloop/screens/authentication/signup_screen.dart';
import 'package:finloop/screens/onboard_screen/onboard_screen.dart';
import 'package:finloop/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());

      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Page not found')),
        );
      },
    );
  }
}
