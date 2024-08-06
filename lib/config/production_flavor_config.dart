part of 'config.dart';

class ProductionConfig implements FlavorConfig {
  @override
  String get appName => "Antinna";

  @override
  final baseUrl = Uri.parse('https://example.com');

  @override
  final flavor = Flavor.production;

  // @override
  // String get version => "$appVersion+$appBuildNumber";
}
