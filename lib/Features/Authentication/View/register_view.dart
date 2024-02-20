import 'package:e_voting_app/Features/Authentication/Controller/authentication_controller.dart';
import 'package:e_voting_app/Features/Authentication/View/login_view.dart';
import 'package:e_voting_app/Utils/app_assets.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_dropdown.dart';
import 'package:e_voting_app/Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Widgets/custom_button.dart';

class register extends StatelessWidget {
   register({super.key});
   final formKey = GlobalKey<FormState>();
  final AuthenticationController authController = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
                Image.asset("assets/images/evoteblack.png"),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: authController.fullName,
                    hidetext: false,
                    keyboardType: TextInputType.name,
                    hint: 'Enter your full name',
                    suffixIcon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: authController.age,
                    hidetext: false,
                    dealAsDate: true,
                    hint: 'Enter your date of birth',
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select date of birth';
                      }else if(authController.getAgeFromDate(value) < 18){
                        return 'You are not eligible for registration';
                      }
                      return null;
                    },),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: authController.email,
                    hidetext: false,
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      }
                      return null;
                    },),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: authController.cNIC,
                    hidetext: false,
                    hint: 'Enter your CNIC',
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.location_city,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your CNIC';
                      }else if(value.length<13){
                        return 'Please enter valid CNIC';
                      }
                      return null;
                    },),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomDropdown(
                    hint: "Select your type",
                    itemList: authController.userTypes,
                    selectedValue: authController.userType,
                    validator: (value) {
                      if (value==null) {
                        return 'Please select your type Voter/Candidate';
                      }
                      return null;
                    },),
                ),
                Obx(
                     ()=> authController.userType.value==AppStrings.candidate
                         ? Column(
                       children: [
                         SizedBox(
                           height: 20.h,
                         ),
                         Obx(
                              () => authController.nameLoader.value
                                  ? Center(child: CircularProgressIndicator(color: Colors.black,),)
                                  : Padding(
                                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                child: CustomDropdown(
                                  hint: "Select your party",
                                  itemList: authController.partyTypes,
                                  selectedValue: authController.partType,
                                  validator: (value) {
                                    if (value==null) {
                                      return 'Please select your party';
                                    }
                                    return null;
                                  },),
                              ),
                         ),
                         SizedBox(
                           height: 20.h,
                         ),
                         Padding(
                           padding: EdgeInsets.only(left: 20.w, right: 20.w),
                           child: CustomDropdown(
                             hint: "Select your election type",
                             itemList: authController.electionTypes,
                             selectedValue: authController.electionType,
                             validator: (value) {
                               if (value==null) {
                                 return 'Please select your election';
                               }
                               return null;
                             },),
                         ),
                       ],
                     )
                         : SizedBox(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: authController.address,
                    hidetext: false,
                    hint: 'Enter your address',
                    keyboardType: TextInputType.text,
                    suffixIcon: Icons.location_on_rounded,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                      () => authController.nameLoader.value
                      ? Center(child: CircularProgressIndicator(color: Colors.black,),)
                      : Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: CustomDropdown(
                      hint: "Select your city",
                      itemList: authController.allCities,
                      selectedValue: authController.cityName,
                      validator: (value) {
                        if (value==null) {
                          return 'Please select your city';
                        }
                        return null;
                      },),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 20.w, right: 20.w),
                //   child: CustomTextFormField(
                //     controller: authController.city,
                //     hidetext: false,
                //     hint: 'Enter your city',
                //     keyboardType: TextInputType.emailAddress,
                //     suffixIcon: Icons.location_city,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Please enter your city';
                //       }
                //       return null;
                //     },),
                // ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(controller: authController.password,
                    hidetext: true,
                    hint: 'Enter your password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: Icons.password,
                    validator
                    :  (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: ()=> authController.scanFinger(),
                  child: Obx(
                    ()=> Image.asset(
                      authController.fngScanned.value
                          ? AppAssets.fingerprintSuccess
                          : AppAssets.fingerprintScan,
                      height: 80.h, width: 80.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  ()=> CustomButton(
                    label: 'Sign Up',
                    loader: authController.loader.value,
                    bgColor: Colors.black,
                    fun: (){
                      if(formKey.currentState!.validate()){
                        authController.registerUser();
                      }
                    }
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            )),
      ),
    );
  }
}
