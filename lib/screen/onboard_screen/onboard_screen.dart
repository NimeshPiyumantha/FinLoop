import 'package:animate_do/animate_do.dart';
import 'package:finloop/generated/assets.dart';
import 'package:finloop/l10n/gen/app_localizations.dart';
import 'package:finloop/services/app_start/app_start_service.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final AppStartService _appStartService = AppStartService();
  int _currentIndex = 0;

  void _onNext(int totalPages) {
    if (_currentIndex < totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    await _appStartService.completeOnboarding();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final List<OnboardingContent> contents = [
      OnboardingContent(
        title: l10n.spendFearlesslyTitle,
        desc: l10n.spendFearlesslyDesc,
        image: Assets.onBoardUi1,
      ),
      OnboardingContent(
        title: l10n.seeWhereItGoesTitle,
        desc: l10n.seeWhereItGoesDesc,
        image: Assets.onBoardUi2,
      ),
      OnboardingContent(
        title: l10n.growYourCityTitle,
        desc: l10n.growYourCityDesc,
        image: Assets.onBoardUi3,
      ),
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 20,
              child: TextButton(
                onPressed: _finishOnboarding,
                child: Text(
                  l10n.skip,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Positioned.fill(
              top: 60,
              bottom: 100,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemCount: contents.length,
                itemBuilder: (context, index) {
                  return _buildPage(contents[index], theme);
                },
              ),
            ),

            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      contents.length,
                      (index) => _buildIndicator(index, theme),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => _onNext(contents.length),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: theme.colorScheme.onSecondary,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingContent content, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FadeInDown(
              child: SizedBox(
                height: 320,
                child: Image.asset(content.image, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 40),

          FadeInUp(
            child: Text(
              content.title,
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 15),

          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Text(
              content.desc,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index, ThemeData theme) {
    bool isActive = _currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 6),
      height: 6,
      width: isActive ? 24 : 6,
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String desc;
  final String image;

  OnboardingContent({
    required this.title,
    required this.desc,
    required this.image,
  });
}
