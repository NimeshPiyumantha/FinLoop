import 'package:shared_preferences/shared_preferences.dart';

import '../base_service/base_service.dart';
import 'Iapp_start_service.dart';

class AppStartService extends BaseService implements IAppStartService {
  static const String _onboardingKey = 'seenOnboarding';

  @override
  Future<String> getInitialRoute() async {
    return await execute<String>(() async {
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      final bool seenOnboarding = prefs.getBool(_onboardingKey) ?? false;

      return seenOnboarding ? '/signin' : '/onboarding';
    });
  }

  @override
  Future<void> completeOnboarding() async {
    await execute<void>(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingKey, true);
    });
  }
}
