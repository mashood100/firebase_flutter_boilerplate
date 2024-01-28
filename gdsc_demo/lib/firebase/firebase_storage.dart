import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Utility class for handling Firebase Storage operations.
class MyFirebaseStorage {
  /// The currently authenticated user.
  static User? user = FirebaseAuth.instance.currentUser;

  /// Uploads the user's profile picture to Firebase Storage and returns the download URL.
  ///
  /// Takes a [profilePic] file as input and generates a unique file name based on the user's UID.
  /// The file is stored in the 'user/{UID}/profile_pic_{UID}' path.
  static Future<String?> uploadUserProfile(File profilePic) async {
    var fileName = "profile_pic_${user!.uid}";
    var storagePath = 'user/${user!.uid}/$fileName';

    // Uploads the file to Firebase Storage and retrieves the download URL.
    var url =
        await uploadFileOnStorage(file: profilePic, filePath: storagePath);

    return url;
  }

  /// Uploads a file to Firebase Storage at the specified [filePath] and returns the download URL.
  ///
  /// Takes a [file] and [filePath] as input, and handles the upload process using FirebaseStorage.
  static Future<String?> uploadFileOnStorage(
      {required File file, required String filePath}) async {
    String? attachmentUrl;

    try {
      // Uploads the file to Firebase Storage.
      await FirebaseStorage.instance
          .ref(filePath)
          .putFile(file)
          .whenComplete(() async {
        // Retrieves the download URL after the file is successfully uploaded.
        var ref = FirebaseStorage.instance.ref().child(filePath);
        attachmentUrl = await ref.getDownloadURL();
      });
    } on FirebaseException catch (e) {
      // Logs an error if the Firebase Storage upload fails.
      log("Error in uploadFileOnStorage: $e");
      return attachmentUrl;
    }

    return attachmentUrl;
  }
}
