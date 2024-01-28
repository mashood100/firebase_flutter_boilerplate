// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

/// Utility class for Firebase Authentication operations.
class MyFirebaseAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static String? uid = auth.currentUser?.uid;
  static User? user = auth.currentUser;

  /// Signs in a user with the provided email and password.
  ///
  /// Returns the signed-in user on success, or null on failure.
  static Future<User?> firebaseSignIn(
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      user = auth.currentUser;
      uid = user?.uid;

      if (user == null) {
        throw FirebaseAuthException(
          code: "firebase-login-failed",
          message: "Authentication failed for email: $email",
        );
      }

      return user;
    } on FirebaseAuthException catch (error) {
      log("Firebase error message: ${error.message}");
      log("Firebase Error code: ${error.code}");
      return null;
    }
  }

  /// Creates a new user account with the provided email and password.
  ///
  /// Returns the created user on success, or null on failure.
  static Future<User?> createFirebaseUser(
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      user = auth.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
          code: "firebase-login-failed",
          message: "Failed to create user with email: $email",
        );
      }

      return user;
    } on FirebaseAuthException catch (error) {
      log("Firebase error message: ${error.message}");
      return null;
    }
  }

  /// Signs out the currently authenticated user.
  static Future<void> firebaseUserLogout() async {
    await auth.signOut();
    uid = null;
  }
}
