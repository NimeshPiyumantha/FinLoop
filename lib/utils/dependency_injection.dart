// import 'package:get_it/get_it.dart';
//
//
// final getIt = GetIt.instance;
//
// void setupLocator() {
//   // 1. Register Repositories
//   // Assuming ConfigurationRepository has a basic constructor.
//   // If it requires arguments, pass them here.
//   getIt.registerLazySingleton<ConfigurationRepository>(
//         () => ConfigurationRepository(),
//   );
//
//   // 2. Register Services
//   getIt.registerLazySingleton<IAuthService>(
//         () => AuthService(configRepository: getIt<ConfigurationRepository>()),
//   );
// }
