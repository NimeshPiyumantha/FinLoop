abstract class IAppStartService {
  Future<String> getInitialRoute();
  Future<void> completeOnboarding();
}
