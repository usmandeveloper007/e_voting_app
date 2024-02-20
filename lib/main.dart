import 'package:e_voting_app/Features/Authentication/View/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Utils/app_assets.dart';
import 'Widgets/error_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return const ErrorScreen();
  };
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.rightToLeftWithFade,
            transitionDuration: Duration(milliseconds: 700),
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: AppAssets.interFont,
              primarySwatch:  Colors.blue,
            ),
            home: child,
          );
        },
        child: Login(),
    );
  }
}

