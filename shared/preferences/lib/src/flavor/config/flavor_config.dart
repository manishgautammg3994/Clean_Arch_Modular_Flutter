part of '../config.dart';

// enum BaseUrlSchema { http, https }

// extension BaseUrlSchemaX on BaseUrlSchema {
//   String toUrlSchema() {
//     switch (this) {
//       case BaseUrlSchema.http:
//         return 'http';
//       case BaseUrlSchema.https:
//         return 'https';
//     }
//   }
// }

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

  // FirebaseOptions get firebaseOptions; //in future if required
  //  @visibleForTesting
  factory FlavorConfig({String? appflavor = appFlavor}) {
    //appflavor is optional just for testing purposes
    switch (appflavor) {
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
