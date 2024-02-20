import 'package:e_voting_app/Features/Result/Widgets/result_banner.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:flutter/material.dart';

import '../../../Utils/app_strings.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../Authentication/Model/user_model.dart';
import '../../Home/View/drawer_screen.dart';
class ResultView extends StatelessWidget {
  final String cityName;
  final String electionType;

  const ResultView({super.key, required this.cityName, required this.electionType});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(
        title: AppStrings.result,
      ),
      drawer:  const DrawerScreen(),
      body: StreamBuilder<List<UserModel>>(
        stream: FireStoreServices.getCandidatesStream(
          cityName: cityName,
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
              return ResultBanner(user: user);
            },
          );
        },
      ),
      // body: SingleChildScrollView(
      //  child: SizedBox(
      //     height: MediaQuery. of(context). size. height,
      //     child: ListView(
      //       children:  const [
      //             ResultBanner(),
      //             ResultBanner(),
      //             ResultBanner(),
      //             ResultBanner(),
      //             ResultBanner(),
      //             ResultBanner(),
      //             ResultBanner(),
      //             ResultBanner(),
      //       ],
      //     ),
      //   ),
      //
      // ),
    );
  }
}
