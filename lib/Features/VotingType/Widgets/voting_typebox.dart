import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class VotingTypeBox extends StatelessWidget {
  final String? votingtypetitle;
  const VotingTypeBox({super.key, this.votingtypetitle});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 250.h,
        width: double.infinity,
        decoration:  BoxDecoration(
          color: AppColors.appbarBgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppStrings.voteFor, style: TextStyle(decoration: TextDecoration.none, color: AppColors.appBgColor,
                fontSize: 26 ),),
            Text(votingtypetitle.toString(), style: TextStyle(decoration: TextDecoration.none, color: AppColors.appBgColor,
            fontSize: 26 ),),
          ],
        ),
      ),
    );
  }
}
