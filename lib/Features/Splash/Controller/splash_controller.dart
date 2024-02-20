import 'package:get/get.dart';
import '../../Home/View/home_screen.dart';



class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 3), ()=> Get.off(HomeScreen()));
  }
}