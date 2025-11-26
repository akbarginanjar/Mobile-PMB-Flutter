import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/utils/theme.dart';
import 'package:pmb_mobile/views/splash_screen/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: defaultTheme(context),
      debugShowCheckedModeBanner: false,
      title: 'PMB',
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
