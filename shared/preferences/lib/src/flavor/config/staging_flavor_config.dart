part of '../config.dart';

class StagingConfig implements FlavorConfig {
  @override
  String get appName => "[STG] Antinna";

  @override
  final baseUrl = Uri.parse('https://stg.example.com');

  @override
  final flavor = Flavor.staging;
}
