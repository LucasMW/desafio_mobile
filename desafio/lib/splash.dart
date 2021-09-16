import 'package:desafio/login_screen.dart';
import 'package:desafio/model/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'common/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<FirebaseApp> _initialization;
  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                color: Colors.red,
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final auth = AuthService();
              //auth.logout();
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                if (auth.isSignedIn()) {
                  Navigator.pushReplacementNamed(context, Constants.routeMap);
                } else {
                  Navigator.pushReplacementNamed(context, Constants.routeLogin);
                }
              });
            }
            return const CircularProgressIndicator();
          }),
    );
    return scaffold;
  }
}
