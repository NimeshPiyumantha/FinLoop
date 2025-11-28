import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfigModel {
  final EnvironmentVariables devVariable;
  final EnvironmentVariables prodVariable;
  final bool? forceAppUpdate;
  final String androidAppVersion;
  final String iosAppVersion;

  AppConfigModel({
    required this.devVariable,
    required this.prodVariable,
    required this.forceAppUpdate,
    required this.androidAppVersion,
    required this.iosAppVersion,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      devVariable: EnvironmentVariables.fromJson(json['dev_variable']),
      prodVariable: EnvironmentVariables.fromJson(json['prod_variable']),
      forceAppUpdate: json['force_app_update'] ?? false,
      androidAppVersion: json['android_app_version'] ?? '',
      iosAppVersion: json['ios_app_version'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dev_variable': devVariable.toJson(),
      'prod_variable': prodVariable.toJson(),
      'force_app_update': forceAppUpdate,
      'android_app_version': androidAppVersion,
      'ios_app_version': iosAppVersion,
    };
  }

  @override
  String toString() {
    return 'AppConfig( devVariable: $devVariable, prodVariable: $prodVariable,  androidAppVersion: $androidAppVersion, iosAppVersion: $iosAppVersion)';
  }
}

class MaintenanceNotification {
  final bool status;
  final String description;

  MaintenanceNotification({required this.status, required this.description});

  factory MaintenanceNotification.fromJson(Map<String, dynamic> json) {
    return MaintenanceNotification(
      status: json['status'] ?? false,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'description': description};
  }

  @override
  String toString() {
    return 'MaintenanceNotification(status: $status, description: $description)';
  }
}

class EnvironmentVariables {
  final String firebasePath;

  EnvironmentVariables({required this.firebasePath});

  factory EnvironmentVariables.fromJson(Map<String, dynamic> json) {
    return EnvironmentVariables(firebasePath: json['FIREBASE_PATH']);
  }

  Map<String, dynamic> toJson() {
    return {'FIREBASE_PATH': firebasePath};
  }

  @override
  String toString() {
    return 'EnvironmentVariables('
        'firebasePath: $firebasePath)';
  }
}
