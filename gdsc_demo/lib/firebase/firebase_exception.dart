import 'package:firebase_auth/firebase_auth.dart';

/// Utility class for handling Firebase authentication exceptions.
class MyFirebaseException {
  /// Returns a user-friendly error message based on the provided [FirebaseAuthException].
  static String authErrors(FirebaseAuthException error) {
    switch (error.code) {
      case "firebase-login-failed":
      case "wrong-password":
      case "INVALID_LOGIN_CREDENTIALS":
      case "user-not-found":
        return "Email and password are incorrect.";
      case "user-disabled":
        return "User with this email has been disabled.";
      case "too-many-requests":
        return "Too many requests. Please try again after some time.";
      case "operation-not-allowed":
        return "Signing in with Email and Password is not enabled.";
      default:
        return "Something went wrong.";
    }
  }
}
