import 'package:cloud_firestore/cloud_firestore.dart';

/// A utility class for interacting with Cloud Firestore.
class MyCloudFirestore {
  /// Reference to the 'users' collection in Cloud Firestore.
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
}
