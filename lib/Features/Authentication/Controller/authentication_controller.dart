
import 'package:biometric_storage/biometric_storage.dart';
import 'package:e_voting_app/Features/Authentication/View/login_view.dart';
import 'package:e_voting_app/Features/Home/View/home_screen.dart';
import 'package:e_voting_app/Features/VoterProfile/Controller/profile_controller.dart';
import 'package:e_voting_app/Services/auth_services.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:e_voting_app/Utils/app_snackbar.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../Model/user_model.dart';

class AuthenticationController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  AuthServices authServices = AuthServices();
  final auth = FirebaseAuth.instance;
  final String bioStorageName = "UserBiometricStorageName";
  var uuid = Uuid();

  final fullName = TextEditingController();
  final age = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  // final city = TextEditingController();
  final cNIC = TextEditingController();
  final password = TextEditingController();
  RxBool loader = false.obs;
  RxBool nameLoader = false.obs;
  RxBool fngScanned = false.obs;
  String? fingerId;
  var userType = Rxn<String>();
  List<String> userTypes = [AppStrings.voter, AppStrings.candidate];

  var partType = Rxn<String>();
  List<String> partyTypes = [];

  var cityName = Rxn<String>();
  List<String> allCities = [];

  var electionType = Rxn<String>();
  List<String> electionTypes = [AppStrings.nationalAssembly, AppStrings.provincialAssembly];

  getCityPartyName() async {
    try{
      nameLoader(true);
      final allNames =await FireStoreServices.getCityPartyName();
      partyTypes=allNames?.parties ?? [];
      allCities=allNames?.cities ?? [];
      nameLoader(false);
    }catch (error){
      nameLoader(false);
      AppSnackBar.errorSnackBar(error.toString());
    }
  }

  registerUser()async{
    CustomTextFormField.dismissKeyboard();
    if(loader.value==false && checkFngScanned()){
      try{
        loader(true);
        bool cNIcExist = await FireStoreServices.isCNICExist(
            int.parse(cNIC.text));
        if (cNIcExist) {
          loader(false);
          AppSnackBar.errorSnackBar("This CNIC already exist.");
          return;
        }
        if(userType.value==AppStrings.candidate){
          bool condExist = await FireStoreServices.isCandidateExist(
              cityName.value??"", partType.value!);
          if (condExist) {
            loader(false);
            AppSnackBar.errorSnackBar("The candidate is already exist in this city from your party respectively.");
            return;
          }
        }

        await authServices.signUpWithEmail(email.text.trim(), password.text.trim()).then((value) async {
          if (value == true) {
            await postDetailsToFirebase();
          }
        });
      }catch (error){
        loader(false);
        AppSnackBar.errorSnackBar(error.toString());
      }
    }
  }

  bool checkFngScanned(){
    if(fngScanned.value==false){
      AppSnackBar.errorSnackBar("Scan your finger to get register");
      return false;
    }else{
      return true;
    }
  }

  postDetailsToFirebase() async {
    final user= UserModel(
      userId: auth.currentUser!.uid,
      fingerId: fingerId,
      fullName: fullName.text,
      age: age.text,
      email: email.text,
      address: address.text,
      city: cityName.value,
      imageUrl: null,
      cNIC: int.tryParse(cNIC.text),
      userType: userType.value,
      partType: partType.value,
      electionType: electionType.value,
      createdAt: DateTime.now().toString(),
      isApproved: false,
    );
    await FireStoreServices.uploadUserData(user).then((value) async {
      if(value){
        await AuthServices.logout();
        loader(false);
        resetFields();
        Get.offAll(()=> Login());
        AppSnackBar.successSnackBar("Your Account Created");
      }
    }).onError((error, stackTrace){
     throw error.toString();
    });
  }

  scanFinger() async {
    try{
      fingerId=uuid.v4();
      final isBioSport = await BiometricStorage().canAuthenticate();
      if (isBioSport == CanAuthenticateResponse.success) {
        final store = await BiometricStorage().getStorage(bioStorageName);
        await store.write(fingerId!);
        fngScanned(true);
      }
    } on AuthException {
      return false;
    }catch (error){
      print(error);
      AppSnackBar.errorSnackBar(error.toString());
    }
  }

  loginAccount() async {
    if (loader.value==false) {
      loader(true);
      try{
        await authServices.login(email.text.trim(), password.text.trim()).then((value) async {
          if(value){
            final user = await profileController.getUserData();
            await FirebaseAuth.instance.currentUser?.reload();
            if(isStatusOk(user!)){
              await profileController.getUserData();
              AppSnackBar.successSnackBar('Login Successful');
              resetFields();
              loader(false);
              Get.offAll(()=> HomeScreen());
              profileController.currentUser=user;
            } else{
              loader(false);
              AuthServices.logout();
            }
          }
        });
      }catch (error){
        loader(false);
        AppSnackBar.errorSnackBar(error.toString());
      }
    }
  }

  bool isStatusOk(UserModel user){
    if(!auth.currentUser!.emailVerified){
      AppSnackBar.errorSnackBar("Your Email Is Not Verified".toString());
      return false;
    }
    else if(user.isApproved==false){
      AppSnackBar.errorSnackBar("You are not approved by the admin");
      return false;
    }
    else{
      return true;
    }
  }

  resetAccount() async {
    CustomTextFormField.dismissKeyboard();
    try{
      loader(true);
      await authServices.resetPassword(email.text).then((value){
        if (value) {
          loader(false);
          resetFields();
          Get.back();
          AppSnackBar.successSnackBar("Email hase been sent to your provided email.");
        }
      });
    } catch (e){
      loader(false);
      print(e);
      AppSnackBar.errorSnackBar(e.toString());
    }
  }

  int getAgeFromDate(String date){
    final nowDate = DateTime.now();
    final dob = DateFormat('dd/MM/yyyy').parse(date);
    final ageInDays = nowDate.difference(dob).inDays;
    final ageInYears = ageInDays/365;
    print(ageInYears.toInt());
    return ageInYears.toInt();
  }


  resetFields(){
  fullName.clear();
  age.clear();
  email.clear();
  address.clear();
  cityName(null);
  cNIC.clear();
  password.clear();
  userType(null);
  partType(null);
  electionType(null);
  fingerId=null;
  fngScanned(false);
  }

}