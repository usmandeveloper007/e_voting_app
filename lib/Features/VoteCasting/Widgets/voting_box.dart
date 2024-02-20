import 'package:e_voting_app/Features/Authentication/Model/user_model.dart';
import 'package:e_voting_app/Features/VoteCasting/Controller/vot_controller.dart';
import 'package:e_voting_app/Features/VoteCasting/Model/election_model.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class VotingBox extends StatelessWidget {
  final UserModel user;

   VotingBox({super.key, required this.user});
   final VotController votController = Get.put(VotController());
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Container(
        // height: 300.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.appbarBgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Padding(
          padding: const EdgeInsets.only(left: 20,top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                children: [
                  const Text(AppStrings.candidateName, style: TextStyle(fontSize: 16, color: AppColors.appBgColor,),),
                  SizedBox(width: 10.w),
                  overFlowText(user.fullName ?? ""),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  const Text(AppStrings.constituency, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                  SizedBox(width: 10.w),
                  overFlowText(user.city ?? ""),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  const Text(AppStrings.partyName, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                  SizedBox(width: 10.w),
                  overFlowText(user.partType ?? ""),
                ],
              ),
              SizedBox(height: 10.h),
              StreamBuilder<ElectionModel>(
                stream: FireStoreServices.getElectionStream(
                  user.electionType ?? ""
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final ElectionModel election = snapshot.data ?? ElectionModel();
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text(AppStrings.votingDate, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                          SizedBox(width: 10.w),
                          overFlowText(election.modDate ?? ""),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Text(AppStrings.voteStartTime, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                          SizedBox(width: 10.w),
                          overFlowText(election.startTime ?? ""),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Text(AppStrings.voteEndTime, style: TextStyle(fontSize: 16, color: AppColors.appBgColor),),
                          SizedBox(width: 10.w),
                          overFlowText(election.endTime ?? ""),
                        ],
                      ),
                      StreamBuilder<dynamic>(
                        stream: votController.timeStream(),
                        builder: (context, snapshot) {
                          votController.checkElectionDateStatus(date: election.modDate, startTime: election.startTime, endTime: election.endTime);
                          return votController.voteDateStatus.value == "Okay"
                              ? StreamBuilder<bool>(
                            stream: FireStoreServices.checkIfUserHasVoted(
                                user.electionType!),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return SizedBox();
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              bool hasVoted = snapshot.data ?? false;
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 40, top: 30, left: 20, bottom: 20),
                                  child: hasVoted
                                      ? Obx(
                                        () => CustomButton(
                                      loader: votController.loader.value,
                                      label: AppStrings.voteNow,
                                      bgColor: AppColors.appBgColor,
                                      fun: () => votController.giveVotToCan(
                                          canId: user.userId!,
                                          electionType: user.electionType!),
                                    ),
                                  )
                                      : SizedBox(
                                    height: 10.h,
                                  ));
                            },
                          )
                              : Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              child: Text(
                                votController.voteDateStatus.value,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.appBgColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget overFlowText(String text){
    return Expanded(
      child: Text(text,
        overflow: TextOverflow.ellipsis,maxLines: 1,
        style: TextStyle(fontSize: 16, color: AppColors.appBgColor,),),
    );
  }

  String todayDate(){
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}
