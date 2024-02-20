import 'package:e_voting_app/Features/Result/View/result_view.dart';
import 'package:e_voting_app/Features/Result/Widgets/constituency_banner.dart';
import 'package:e_voting_app/Services/fire_store_services.dart';
import 'package:e_voting_app/Utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/app_strings.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../Home/View/drawer_screen.dart';
class ConsituencyView extends StatelessWidget {
  final String electionType;

  const ConsituencyView({super.key, required this.electionType});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(
        title: AppStrings.constituencyMark,
      ),
      drawer:  const DrawerScreen(),
      body:  StreamBuilder<List<String>>(
        stream: FireStoreServices.fetchAllCityNames(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasError) {
            AppSnackBar.errorSnackBar(snapshot.error.toString());
            return SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final cityList = snapshot.data ?? [];
          return ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: ()=> Get.to(()=> ResultView(
                    cityName: cityList[index],
                    electionType: electionType,
                  )),
                  child: ConstituencyBanner(city: cityList[index]));
            },
          );
        },
      ),
      // body: SingleChildScrollView(
      //   child: SizedBox(
      //     height: MediaQuery. of(context). size. height,
      //     child: ListView(
      //       children:  [
      //         GestureDetector(
      //             onTap: ()=> Get.to(()=> ResultView(
      //               cityName: "Lahore",
      //               electionType: electionType,
      //             )),
      //             child: const ConstituencyBanner()),
      //         ConstituencyBanner(),
      //         ConstituencyBanner(),
      //         ConstituencyBanner(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
