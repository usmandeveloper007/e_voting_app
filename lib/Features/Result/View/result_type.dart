import 'package:e_voting_app/Features/Home/View/drawer_screen.dart';
import 'package:e_voting_app/Features/Result/View/constituency_view.dart';
import 'package:e_voting_app/Features/Result/Widgets/result_typebox.dart';
import 'package:e_voting_app/Features/VoteCasting/View/vote_casting.dart';
import 'package:e_voting_app/Features/VotingType/Widgets/voting_typebox.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class ResultType extends StatelessWidget {
  const ResultType({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(
        title: AppStrings.result,
      ),
      drawer:  const DrawerScreen(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: ()=> Get.to(()=> ConsituencyView(electionType: AppStrings.nationalAssembly,)),
              child: const ResultTypeBox(votingtypetitle: AppStrings.nationalAssemblyMark,)),
          SizedBox(height: 30.h),
          GestureDetector(
              onTap: ()=> Get.to(()=> ConsituencyView(electionType: AppStrings.provincialAssembly,)),
              child: const ResultTypeBox(votingtypetitle: AppStrings.provincialAssemblyMark,)),
        ],
      ),
    );
  }
}
