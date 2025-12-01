import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmb_mobile/views/admin/dashboard_admin_screen/screen.dart';
import 'package:pmb_mobile/views/admin/main_screen/screen.dart';
import 'package:pmb_mobile/views/home_screen/screen.dart';
import 'package:pmb_mobile/views/mahasiswa/main_screen/screen.dart';

class SplashController extends GetxController {
  GetStorage box = GetStorage();

  @override
  void onInit() {
    startSplashScreen();
    super.onInit();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Get.offAll(
        box.read('pid') != null && box.read('pid') != 1
            ? const MainScreenMahasiswa()
            : box.read('pid') == 1
            ? const MainScreenAdmin()
            : HomeScreen(),
      );
    });
  }
}
