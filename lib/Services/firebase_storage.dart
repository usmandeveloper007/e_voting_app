

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_exceptions.dart';

class FireBaseStorage {
  static final _firebaseStorage = FirebaseStorage.instance;

  static Future<String?> uploadImageOnStorage({required File image, required String imageName, required String folderName, required String subFolderName}) async {
    try{
      var snapshot = await _firebaseStorage.ref()
          .child(folderName).child(subFolderName).child('$imageName${DateTime.now()}')
          .putFile(image);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      return downloadUrl;
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      rethrow;
    }
  }

  static Future<bool> deleteImageFromStorage(String url) async {
    try{
      var storageReference = _firebaseStorage.refFromURL(url);
      await storageReference.delete();
      return true;
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      rethrow;
    }
  }

}