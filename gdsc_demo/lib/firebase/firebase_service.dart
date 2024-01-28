import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyFirebaseService {
  final BuildContext context;

  MyFirebaseService({required this.context});

  /// Initializes Firebase services.
  static Future<void> initializeService() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      log('Error initializing Firebase: $e');
    }
  }

  /// Initializes Firebase Crashlytics for release and profile modes.
  static void initializeFirebaseCrashlytics() {
    if (kReleaseMode || kProfileMode) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  /// Retrieves the Firebase Cloud Messaging (FCM) token.
  static Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
