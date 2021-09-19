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

  Future<void> _showMyDialog(String title, {String? message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message ?? "User couldn't login"),
                Text('Are Email and Password correct?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void goToMap() {
    Navigator.pushNamed(context, Constants.routeMap);
  }

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final emailField = TextField(
    key: const Key(Constants.keyLogin),
    controller: TextEditingController(),
    //style: style,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );
  final passwordField = TextField(
    key: const Key(Constants.keyPassword),
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
      key: const Key(Constants.keyLoginButton),
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xFF002934),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          final email = emailField.controller?.text.trim() ?? "none";
          final password = passwordField.controller?.text.trim() ?? "none";
          print("Will signin with $email, $password");
          auth.signIn(email, password).then((success) {
            if (success) {
              goToMap();
            } else {
              _showMyDialog("Couldn't Login", message: auth.errorMessage);
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
