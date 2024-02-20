import 'package:e_voting_app/Features/Authentication/Model/user_model.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultBanner extends StatelessWidget {
  final UserModel user;

  const ResultBanner({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.all(10.sp),
      child: Card(
        elevation: 5,
        color: AppColors.appbarBgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            children: [
              CustomNetworkImage(
                  url: user.imageUrl,
                  height: 70.w, width: 70.w,
                  radius: 100.r
              ),
              SizedBox(width: 12.w,),
              Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(AppStrings.candidateName, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(user.fullName ?? "",
                              overflow: TextOverflow.visible, maxLines: 2,
                              style: TextStyle(fontSize: 16, color: AppColors.appBgColor,),),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            const Text(AppStrings.partyName, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(user.partType ?? "",
                                overflow: TextOverflow.visible, maxLines: 1,
                                style: TextStyle(fontSize: 16, color: AppColors.appBgColor,),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            const Text(AppStrings.voteCount, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                            SizedBox(width: 10.w),
                            StreamBuilder<int>(
                              stream: FireStoreServices.getVoteResultsStream(
                                  canId: user.userId!, electionType: user.electionType!),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return SizedBox();
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                int voteCount = snapshot.data ?? 0;

                                return Text(voteCount.toString(), style: TextStyle(fontSize: 16, color: AppColors.appBgColor,),);
                              },
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}