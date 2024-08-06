import 'dart:io';

import 'package:antinna/config/config.dart';
import 'package:component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RendererBinding;

import 'backend/backend_inherited_widget_helper.dart';
import 'utils/helpers/component_init.dart';

class AntinnaApp extends StatefulWidget {
  const AntinnaApp({super.key, required this.config});

  final FlavorConfig config;
  @override
  State<AntinnaApp> createState() => _AntinnaAppState();
}

class _AntinnaAppState extends State<AntinnaApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get navigatorState => _navigatorKey.currentState;
  final _deviceTypeNotifier = DeviceTypeOrientationNotifier();
  late Future<Backend> _appLoader;

  // late final _connectivity = _connectivityStream();
  //  Stream<ConnectivityResult> _connectivityStream() async* {
  //   try {
  //     final connectivity = Connectivity();
  //     final result = await connectivity.checkConnectivity();
  //     yield result.first; //single distinct result only
  //     yield* connectivity.onConnectivityChanged
  //         .expand((results) => results); // Flatten the stream
  //   } catch (e) {
  //     // Handle the error appropriately
  //     debugPrint('Connectivity error: $e');
  //   }
  // }

  @override
  void initState() {
    _deviceTypeNotifier.init();
    RendererBinding.instance
        .deferFirstFrame(); //hold the first frame , untill show the platform default Native Splash if not then white color screen
    super.initState();
    Intl.defaultLocale = PlatformDispatcher.instance.locale
        .toLanguageTag(); //usefull For Manish //! TODO: support
    _appLoader = _loadApp();
  }

  Future<Backend> _loadApp() async {
    await Future.delayed(Duration(seconds: 5)); //TODO: remove in future
    if (widget.config.flavor == Flavor.development) {
      // EquatableConfig.stringify = true;
    }
    await initializeDateFormatting(); //usefull For Manish //! TODO: support
    final backend = await Backend.init(
      widget.config,
      _deviceTypeNotifier,
    );
    // _isLoggedIn = backend.authRepo.isLoggedIn;
    // _subIsLoggedIn = backend
    //     .authRepo //
    //     .streamIsLoggedIn
    //     .listen(_onLoginStateChanged); //usefull For Manish //! TODO: support
    // if (mounted) {
    //   await MainScreen.precacheImages();
    // }
    return backend;
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
    _deviceTypeNotifier.dispose();

    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MainApp.app(
  //     isIOS: kIsWeb ? false : Platform.isIOS,
  //     config: widget.config,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: _connectivity,
        builder: (BuildContext context,
            AsyncSnapshot<ConnectivityResult> streamSnapshot) {
          if (streamSnapshot.connectionState != ConnectionState.active) {
            return CircularProgressIndicator(); //TODO load splash here
          } else {
            final result = streamSnapshot.requireData;
            return BannerHost(
              hideBanner: result != ConnectivityResult.none,
              banner: Directionality(
                textDirection: TextDirection.ltr,
                child: Theme(
                    data: ThemeData.from(
                        colorScheme:
                            ColorScheme.fromSeed(seedColor: Colors.red)),
                    child: Material(
                      color: (result != ConnectivityResult.none)
                          ? Colors.green
                          : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 12.0),
                        child: Text(
                          (result != ConnectivityResult.none)
                              ? "Connected"
                              : 'No Internet',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
              child: FutureBuilder<Backend>(
                  future: _appLoader,
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.connectionState !=
                        ConnectionState.done) {
                      //TODO: load splash here
                      return Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                    return BackendInheritedWidget(
                        backend: futureSnapshot.requireData,
                        child: MainApp.app(
                          isIOS: kIsWeb ? false : Platform.isIOS,
                          config: futureSnapshot.data!.config,
                        )
                        //this
                        );
                  }),
            );
          }
        });
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
