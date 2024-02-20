import 'dart:io';
import 'package:e_voting_app/Features/Authentication/Model/user_model.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:e_voting_app/Services/firebase_storage.dart';
import 'package:e_voting_app/Utils/app_snackbar.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final name = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final type = TextEditingController();
  UserModel currentUser = UserModel();
  var pickedImage = Rxn<XFile>();
  var userGallery = <String>[].obs;
  var profileImage = Rxn<String>();
  RxBool profileImageLoader = false.obs;

  Future<UserModel?> getUserData() async {
    try{
      UserModel? user;
      await FireStoreServices.getUser().then((value) async {
        if(value!=null){
          currentUser = value;
          name.text=value.fullName ?? "";
          email.text=value.email ?? "";
          address.text=value.address ?? "";
          city.text=value.city ?? "";
          type.text=value.userType ?? "";
          profileImage.value = value.imageUrl;
          user = value;
        }
      });
      return user;
    }catch(error){
      print(error.toString());
      AppSnackBar.errorSnackBar(error.toString());
      return null;
    }
  }

  Future pickAndSaveProfileImage() async {
    try{
      await pickImage(ImageSource.gallery);
      if(pickedImage.value != null){
        profileImageLoader(true);
        await addProfileImagesIntoFireStore(
            imageUrl: await uploadImageOnStorage("Profile")
        );
        profileImageLoader(false);
        AppSnackBar.successSnackBar('Image Uploaded Success');
        pickedImage.value=null;
      }
      profileImageLoader(false);
    }catch(error) {
      print(error);
      profileImageLoader(false);
      AppSnackBar.errorSnackBar(error.toString());
    }
  }

  Future pickImage(ImageSource source,) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      // maxWidth: maxWidth,
      // maxHeight: maxHeight,
      // imageQuality: quality,
    );
    pickedImage.value = pickedFile;
  }

  Future <String> uploadImageOnStorage (String subFolderName) async {
    final String? imageUrl = await FireBaseStorage.uploadImageOnStorage(
        image: File(pickedImage.value!.path),
        imageName: pickedImage.value!.name,
        folderName: email.text,
        subFolderName: subFolderName);
    return imageUrl!;
  }

  Future addProfileImagesIntoFireStore({required String imageUrl}) async {
    await FireStoreServices.updateUserProfile({'imageUrl' : imageUrl});
    if(profileImage.value != null){
      await FireBaseStorage.deleteImageFromStorage(profileImage.value!);
    }
    profileImage.value = imageUrl;
  }


}