import 'package:desafio/common/constants.dart';
import 'package:desafio/login_screen.dart';
import 'package:desafio/map.dart';
import 'package:desafio/model/analytics.dart';
import 'package:desafio/splash.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [AnalyticsService().getNavigationObserver()],
      routes: {
        Constants.routeMap: (context) => const MapScreen(
              key: Key(Constants.keyMapScreen),
            ),
        Constants.routeLogin: (context) => const LoginScreen(),
        Constants.routeSplash: (context) => const SplashScreen(),
      },
      initialRoute: Constants.routeSplash,
    );
  }
}
