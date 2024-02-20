import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:flutter/material.dart';

class ConstituencyBanner extends StatelessWidget {
final String city;

  const ConstituencyBanner({super.key, required this.city});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListTile(
          textColor: AppColors.appBgColor,
          tileColor: AppColors.appbarBgColor,
          contentPadding: EdgeInsets.only(bottom: 10, top: 10),
          title: Center(child: Text(AppStrings.constituencyMark, style: TextStyle(fontSize: 14),)),
          subtitle: Center(child: Text(city, style: TextStyle(fontSize: 24),)),
        ),
      );
  }
}

//List Tile Code

//ListView(
//         children: const [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: const Color(0xff764abc),
//             ),
//             title: Text('Car'),
//             trailing: Icon(Icons.more_vert),
//           ),
//           ListTile(
//             leading: Icon(Icons.flight),
//             title: Text('Flight'),
//             trailing: Icon(Icons.more_vert),
//           ),
//           ListTile(
//             leading: Icon(Icons.train),
//             title: Text('Train'),
//             trailing: Icon(Icons.more_vert),
//           )
//         ],
//       ),
