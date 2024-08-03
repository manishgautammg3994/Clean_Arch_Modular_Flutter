import 'package:flutter/material.dart';

import 'config/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final FlavorConfig config = FlavorConfig();

  runApp(const MyApp());
}
