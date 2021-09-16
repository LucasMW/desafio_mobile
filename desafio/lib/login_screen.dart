import 'package:desafio/model/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:desafio/common/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = AuthService();
  @override
  void initState() {
    super.initState();
  }

  void goToMap() {
    Navigator.pushNamed(context, Constants.routeMap);
  }

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final emailField = TextField(
    controller: TextEditingController(),
    //style: style,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );
  final passwordField = TextField(
    controller: TextEditingController(),
    obscureText: true,
    //style: style,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  @override
  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xFF002934),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          final email = emailField.controller?.text.trim() ?? "none";
          final password = passwordField.controller?.text.trim() ?? "none";
          print("Will signin with $email, $password");
          auth.signIn(email, password).then((success) {
            if (success) {
              goToMap();
            } else {
              print("Show message");
            }
          });
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("LoginScreen"),
                  const SizedBox(height: 100),
                  emailField,
                  const SizedBox(height: 10),
                  passwordField,
                  const SizedBox(height: 50),
                  loginButon
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
