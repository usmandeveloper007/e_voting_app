import 'package:biometric_storage/biometric_storage.dart';
import 'package:e_voting_app/Features/VoteCasting/Model/vot_model.dart';
import 'package:e_voting_app/Features/VoterProfile/Controller/profile_controller.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:e_voting_app/Utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class VotController extends GetxController {
  final String bioStorageName = "UserBiometricStorageName";
  var uuid = Uuid();
  RxBool loader=false.obs;
  RxString voteDateStatus = "".obs;

  giveVotToCan({required String canId, required String electionType}) async {
    ProfileController profileController = Get.find();
    final userBioId = profileController.currentUser.fingerId;
    final vot = VotModel(
        votId : uuid.v4(),
        votTo : canId,
        votFrom : profileController.currentUser.userId,
        votAt : DateTime.now().toString(),
        electionType : electionType,
    );
    try{
      final bioId = await scanFinger();
      print("Saved Bio $bioId");
      print("User Firebase Bio $userBioId");
      if(bioId == userBioId){
        await FireStoreServices.postNewVot(vot).then((value){
          if(value){
            AppSnackBar.successSnackBar("Your vot posted");
          }
        });
      }else{
        throw "Your finger data not match with our database";
      }
    }catch (error){
      AppSnackBar.errorSnackBar(error.toString());
    }
  }


  Future<String?> scanFinger() async {
    try{
      final isBioSport = await BiometricStorage().canAuthenticate();
      if (isBioSport == CanAuthenticateResponse.success) {
        final store = await BiometricStorage().getStorage(bioStorageName);
        return await store.read();
      }else{
        return null;
      }
    } on AuthException {
      return null;
    }catch (error){
      AppSnackBar.errorSnackBar(error.toString());
      return null;
    }
  }

  Stream timeStream(){
    DateTime current = DateTime.now();
    return  Stream.periodic( Duration(seconds: 40), (i){
      current = current.add(Duration(seconds: 40));
      return current;
    });
  }


   checkElectionDateStatus({String? date, String? startTime, String? endTime}) {
    DateTime currentDate = DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    DateTime currentTime = DateFormat('HH:mm').parse(DateFormat('HH:mm').format(DateTime.now()));
   if(isDateTimeNotNull(date: date, startTime: startTime, endTime: endTime)){
     DateTime eventDate = DateFormat('dd/MM/yyyy').parse(date!);
     DateTime eventStartTime = DateFormat('HH:mm').parse(startTime!);
     DateTime eventEndTime = DateFormat('HH:mm').parse(endTime!);
     if (eventDate.isBefore(currentDate)) {
       print(eventDate);
       print(currentDate);
       voteDateStatus.value= "This Election is expired";
     } else if (eventDate.isAfter(currentDate)) {
       voteDateStatus.value= "This Election is coming soon";
     } else {
       if (eventStartTime.isAfter(currentTime)) {
         voteDateStatus.value= "Election time has not started";
       } else if (eventEndTime.isBefore(currentTime)) {
         voteDateStatus.value= "Election time has ended";
       } else {
         voteDateStatus.value= "Okay";
       }
     }
   }
  }

  isDateTimeNotNull({String? date, String? startTime, String? endTime}){
    if(date==null || date.isEmpty){
      voteDateStatus.value= "Election date is not final";
      return false;
    }
    else if(startTime==null || startTime.isEmpty){
      voteDateStatus.value= "Election start time is not final";
      return false;
    }
    else if(endTime==null || endTime.isEmpty){
      voteDateStatus.value= "Election end time is not final";
      return false;
    }
    else {
      return true;
    }
  }


}