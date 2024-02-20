import 'package:e_voting_app/Features/Home/View/drawer_screen.dart';
import 'package:e_voting_app/Features/VoteCasting/Widgets/voting_box.dart';
import 'package:e_voting_app/Features/VoterProfile/Controller/profile_controller.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Authentication/Model/user_model.dart';
class VoteCasting extends StatelessWidget {
  final String electionType;
 final ProfileController profileController = Get.put(ProfileController());

   VoteCasting({super.key, required this.electionType});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(
        title: AppStrings.voteCasting,
      ),
      drawer:  DrawerScreen(),
      body: StreamBuilder<List<UserModel>>(
        stream: FireStoreServices.getCandidatesStream(
            cityName: profileController.currentUser.city!,
          electionType: electionType,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final List<UserModel> users = snapshot.data ?? [];
          print(users.length);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final UserModel user = users[index];
              return VotingBox(user: user);
            },
          );
        },
      )
      ,
      // body: SingleChildScrollView(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //
      //       VotingBox(),
      //     ],
      //   ),
      // ),
    );
  }
}
