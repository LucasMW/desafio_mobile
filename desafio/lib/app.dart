import 'package:desafio/common/constants.dart';
import 'package:desafio/login_screen.dart';
import 'package:desafio/map.dart';
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
      routes: {
        Constants.routeMap: (context) => MapScreen(
              key: const Key(Constants.keyMapScreen),
            ),
        Constants.routeLogin: (context) => LoginScreen(),
        Constants.routeSplash: (context) => SplashScreen(),
      },
      initialRoute: Constants.routeSplash,
    );
  }
}
