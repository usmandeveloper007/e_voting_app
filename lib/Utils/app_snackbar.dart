import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
 static successSnackBar(String content){
    Get.snackbar(
      "Success",
      content,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add_alert,  color: Colors.white),
    );
  }

 static errorSnackBar(String error){
   Get.snackbar(
     "Error",
     error,
     colorText: Colors.white,
     backgroundColor: Colors.red,
     icon: const Icon(Icons.error, color: Colors.white,),
   );
 }
}