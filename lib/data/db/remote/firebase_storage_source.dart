import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tinder_new/data/db/remote/response.dart';

class FirebaseStorageSource {
  FirebaseStorage instance = FirebaseStorage.instance;

  Future<Response<String>> uploadUserProfilePhoto(
      Uint8List fileBytes, String userId) async {
    String userPhotoPath = "user_photos/$userId/profile_photo";

    try {
      await instance
          .ref(userPhotoPath)
          .putData(fileBytes, SettableMetadata(contentType: "image/jpeg"));
      String downloadUrl = await instance.ref(userPhotoPath).getDownloadURL();
      return Response.success(downloadUrl);
    } catch (e) {
      return Response.error(((e as FirebaseException).message ?? e.toString()));
    }
  }
}
