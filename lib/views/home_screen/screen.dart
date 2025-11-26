import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/views/home_screen/header_image.dart';
import 'package:pmb_mobile/views/admin/login_admin_screen/screen.dart';
import 'package:pmb_mobile/views/mahasiswa/login_screen/screen.dart';
import 'package:pmb_mobile/views/mahasiswa/register_screen/screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderImage(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selamat Datang",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  "Silahkan Masuk",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(RegisterScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                    child: Text(
                      'Buat Akun',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text('ATAU', style: TextStyle(color: Colors.grey)),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(LoginAdminScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: Colors.black87),
                        SizedBox(width: 5),
                        Text(
                          'Login Admin',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
