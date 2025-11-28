import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../services/app_start/app_start_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppStartService _appStartService = AppStartService();

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final route = await _appStartService.getInitialRoute();

    if (mounted) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Stack(
          children: [
            Center(
              child: FadeInDown(
                duration: const Duration(milliseconds: 1200),
                child: Image.asset(Assets.splashLogo, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 1200),
                        builder: (context, value, child) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 10,
                            color: theme.colorScheme.primary,
                            backgroundColor: theme.colorScheme.primary
                                .withOpacity(0.2),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
