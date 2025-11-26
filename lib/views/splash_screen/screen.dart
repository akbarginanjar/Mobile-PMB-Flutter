import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/splash_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (s) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Image.asset('assets/images/logo_bsi.png', scale: 1.3),
              ),
              Column(
                children: [
                  Text(
                    'PMB',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Penerimaan Mahasiswa Baru',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 13,
                    width: 150,
                    child: Card(
                      margin: EdgeInsets.only(top: 8),
                      elevation: 0,
                      color: primary,
                      child: Text('-', style: TextStyle(color: primary)),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
