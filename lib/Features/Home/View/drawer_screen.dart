import 'package:e_voting_app/Features/ApplyForCandidate/View/apply_forcandidate.dart';
import 'package:e_voting_app/Features/Authentication/View/login_view.dart';
import 'package:e_voting_app/Features/ElectionCreation/View/election_creationview.dart';
import 'package:e_voting_app/Features/Home/View/home_screen.dart';
import 'package:e_voting_app/Features/VoterProfile/View/voter_profile.dart';
import 'package:e_voting_app/Services/auth_services.dart';
import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../VotingType/View/voting_type.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Drawer(
        child: ListView(
            children:[
               DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.appbarBgColor,
                ),
                child: Center(child: Image.asset("assets/images/evotewhite.png"),),
              ),
              ListTile(
                title: const Text(AppStrings.home),
                onTap: ()=> Get.offAll(()=> HomeScreen()),
              ),

              ListTile(
                title: const Text(AppStrings.profile),
                onTap: ()=> Get.to(()=> VoterProfile()),
              ),
              ListTile(
                title: const Text(AppStrings.voteNow),
                onTap: ()=> Get.to(()=> VotingType()),
              ),
              // ListTile(
              //   title: const Text(AppStrings.applyForCandidate),
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => const ApplyForCandidate()));
              //   },
              // ),
              // ListTile(
              //   title: const Text(AppStrings.createElection),
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => const ElectionCreation()));
              //   },
              // ),
              // ListTile(
              //   title: const Text(AppStrings.loginAsAdmin),
              //   onTap: () {
              //     // Handle item 2 click
              //   },
              // ),
              ListTile(
                title: const Text(AppStrings.logout),
                onTap: () {
                  Get.offAll(()=> Login());
                  AuthServices.logout();
                },
              ),
              SizedBox(
                height: 280.h,
              ),
              ListTile(
                title: const Text(AppStrings.contactUs),
                subtitle: const Text(AppStrings.adminEmail),
              ),


            ]
        )
    );
  }
}
