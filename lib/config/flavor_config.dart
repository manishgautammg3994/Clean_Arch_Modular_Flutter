part of 'config.dart';

enum Flavor {
  // set them in alphabatical order with full name
  development,
  production,
  staging
}

abstract class FlavorConfig {
  String get appName;
  Uri get baseUrl;
  Flavor get flavor;
  // String get version;

  factory FlavorConfig() {
    switch (appFlavor) {
      case "development":
        return DevelopmentConfig();
      case "staging":
        return StagingConfig();
      case "production":
      default:
        return ProductionConfig();
    }
  }
}
