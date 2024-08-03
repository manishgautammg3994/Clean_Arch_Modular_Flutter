import 'dart:io';
import 'dart:ui_web';

import 'package:antinna/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RendererBinding;

class AntinnaApp extends StatefulWidget {
  const AntinnaApp({super.key, required this.config});

  final FlavorConfig config;
  @override
  State<AntinnaApp> createState() => _AntinnaAppState();
}

class _AntinnaAppState extends State<AntinnaApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get navigatorState => _navigatorKey.currentState;
  //  final _deviceTypeNotifier = DeviceTypeOrientationNotifier();

  @override
  void initState() {
    //  _deviceTypeNotifier.init();
    RendererBinding.instance
        .deferFirstFrame(); //hold the first frame , untill show the platform default Native Splash if not then white color screen
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allowFirstFrame();
    super.didChangeDependencies();
  }

  void allowFirstFrame() {
    final renderer = RendererBinding.instance;
    if (!renderer.sendFramesToEngine) {
      renderer.allowFirstFrame();
    }
  }

  @override
  void dispose() {
    // _deviceTypeNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainApp.app(
      isIOS: kIsWeb ? false : Platform.isIOS,
      config: widget.config,
    );
  }
}

abstract class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Factory constructor to handle different platforms
  factory MainApp.app({bool? isIOS, required FlavorConfig config}) {
    if (isIOS ?? false) {
      return MainIosApp(
        config: config,
      );
    } else {
      return MainAndroidApp(
        config: config,
      );
    }
  }
}

class MainAndroidApp extends MainApp {
  const MainAndroidApp({required this.config, super.key});
  final FlavorConfig config;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          config.flavor == Flavor.development ? true : false,
      title: config.appName,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Android App'),
        ),
        body: Center(
          child: Text('This is the Android app on ${config.flavor.name}'),
        ),
      ),
    );
  }
}

class MainIosApp extends MainApp {
  const MainIosApp({required this.config, super.key});

  final FlavorConfig config;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp();
  }
}
