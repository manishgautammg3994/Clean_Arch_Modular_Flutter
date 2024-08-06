import 'package:flutter/material.dart';

import 'bootstrap.dart';
import 'config/config.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  final FlavorConfig config = FlavorConfig();

  //dont add any extra function / method call in main function except runApp
  runApp(AntinnaApp(config: config));
}
