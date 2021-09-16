// Imports the Flutter Driver API.
import 'package:desafio/common/constants.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Login', () {
    late FlutterDriver driver;
    final loginFieldFinder = find.byValueKey(Constants.keyLogin);
    final passwordFieldFinder = find.byValueKey(Constants.keyPassword);
    final buttonFinder = find.byValueKey(Constants.keyLoginButton);
    final mapScreenFinder = find.byValueKey(Constants.keyMapScreen);
    const loginStr = "exemplo@exemplo.com";
    const passwordStr = "exemplo";

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    Future<void> fillLogin() async {
      await driver.waitFor(loginFieldFinder);
      await driver.tap(loginFieldFinder);
      await driver.enterText(loginStr);
    }

    Future<void> fillPassword() async {
      await driver.waitFor(passwordFieldFinder);
      await driver.tap(passwordFieldFinder);
      await driver.enterText(passwordStr);
    }

    test('clear', () async {
      await driver.clearTimeline();
    });
    test('fill Login', () async {
      await fillLogin();
      final login = await driver.getText(loginFieldFinder);
      expect(login, loginStr);
    });

    test('fill Password', () async {
      await fillPassword();
      final pass = await driver.getText(passwordFieldFinder);
      expect(pass, passwordStr);
    });

    test('Do sign In', () async {
      await driver.tap(buttonFinder);
      await driver.waitFor(mapScreenFinder);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });
  });
}
