import 'package:desafio/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SafeArea(
                  child: Container(
                    color: Colors.red,
                    child: Text(snapshot.error.toString()),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var materialApp = MaterialApp(
                  title: 'Desafio',
                  theme: ThemeData(
                    primarySwatch: Colors.indigo,
                  ),
                  home: LoginScreen(),
                );
                return materialApp;
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
