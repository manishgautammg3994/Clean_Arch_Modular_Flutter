part of '../config.dart';

class DevelopmentConfig implements FlavorConfig {
  @override
  String get appName => "[DEV] Antinna";

  @override
  final baseUrl = Uri.parse('https://dev.example.com');

  @override
  final flavor = Flavor.development;
}
