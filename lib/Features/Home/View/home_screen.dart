import 'package:e_voting_app/Features/ApplyForCandidate/View/apply_forcandidate.dart';
import 'package:e_voting_app/Features/ElectionCreation/View/election_creationview.dart';
import 'package:e_voting_app/Features/Home/Widgets/home_gridView.dart';
import 'package:e_voting_app/Features/Result/View/result_type.dart';
import 'package:e_voting_app/Features/User%20Manual/View/user_manual.dart';
import 'package:e_voting_app/Features/VoterProfile/View/voter_profile.dart';
import 'package:e_voting_app/Features/VotingType/View/voting_type.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/app_colors.dart';
import '../../../Widgets/custom_appbar.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: const CustomAppbar(
        title: AppStrings.dashBoard,
      ),
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Image.asset("assets/images/evoteblack200.png"),
            Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w,),
                child: SizedBox(
                  height: 550.h,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      GestureDetector(
                          onTap: ()=> Get.to(()=> VotingType()),
                          child: const HomeGridView(
                            image: 'assets/images/ballot.png',
                            title: AppStrings.voteNow,
                          )),

                      GestureDetector(
                        onTap: ()=> Get.to(()=> ResultType()),
                        child: const HomeGridView(
                          image: 'assets/images/result.png',
                          title: AppStrings.result,
                        ),
                      ),
                      GestureDetector(
                          onTap: ()=> Get.to(()=> VoterProfile()),
                          child: const HomeGridView(
                            image: 'assets/images/user.png',
                            title: AppStrings.profile,
                          )),
                      GestureDetector(
                          onTap: ()=> Get.to(()=> userManual(videoId: 'h0oOPL8PDgM',)),
                          child: const HomeGridView(
                            image: 'assets/images/candidates.png',
                            title: AppStrings.userManual,
                          )),
                    ],
                  ),

                )),
          ],
        ),
      ),
    );
  }
}
