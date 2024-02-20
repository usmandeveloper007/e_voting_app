import 'package:e_voting_app/Features/Home/View/drawer_screen.dart';
import 'package:e_voting_app/Features/VoterProfile/Controller/profile_controller.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_appbar.dart';
import 'package:e_voting_app/Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Widgets/custom_network_image.dart';

class VoterProfile extends StatelessWidget {
  VoterProfile({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: AppStrings.profile,
      ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileController.currentUser.userType == AppStrings.voter
                ? SizedBox(
                    height: 140.h,
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100.r),
                      onTap: () => profileController.pickAndSaveProfileImage(),
                      child: Obx(
                        () => Container(
                            height: 120.w,
                            width: 120.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38.withOpacity(0.1),
                                      spreadRadius: 4,
                                      blurRadius: 4)
                                ]),
                            child: profileController.profileImageLoader.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : profileController.profileImage.value == null
                                    ? Center(
                                        child: Text(
                                        "Chose Image",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ))
                                    : CustomNetworkImage(
                                        url: profileController
                                            .profileImage.value,
                                        height: 120.w,
                                        width: 120.w,
                                        radius: 100.r,
                                      )),
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: CustomTextFormField(
                controller: profileController.name,
                hidetext: false,
                keyboardType: TextInputType.name,
                hint: 'Your full name',
                suffixIcon: Icons.person,
                enabled: false,
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
                controller: profileController.email,
                hidetext: false,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                hint: 'Your email address',
                suffixIcon: Icons.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
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
                controller: profileController.address,
                hidetext: false,
                enabled: false,
                keyboardType: TextInputType.text,
                hint: 'Your address',
                suffixIcon: Icons.location_on_rounded,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
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
                controller: profileController.city,
                hidetext: false,
                enabled: false,
                keyboardType: TextInputType.text,
                hint: 'Your city',
                suffixIcon: Icons.location_city,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your city';
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
                controller: profileController.type,
                hidetext: false,
                enabled: false,
                keyboardType: TextInputType.text,
                hint: 'User Type',
                suffixIcon: Icons.location_city,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
