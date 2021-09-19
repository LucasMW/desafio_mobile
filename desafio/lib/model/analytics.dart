import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  FirebaseAnalytics analytics = FirebaseAnalytics();
  AnalyticsService._privateConstructor();

  static final AnalyticsService _instance =
      AnalyticsService._privateConstructor();

  factory AnalyticsService() {
    return _instance;
  }
  FirebaseAnalyticsObserver getNavigationObserver() {
    return FirebaseAnalyticsObserver(analytics: analytics);
  }

  Future<void> sendAnalyticsEvent(String name,
      {Map<String, Object?>? parameters}) async {
    return analytics.logEvent(name: name, parameters: parameters);
  }
}
