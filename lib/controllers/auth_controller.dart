import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmb_mobile/services/auth_service.dart';
import 'package:pmb_mobile/views/mahasiswa/dashboard_mahasiswa_screen/screen.dart';
import 'package:pmb_mobile/views/admin/main_screen/screen.dart';
import 'package:pmb_mobile/views/mahasiswa/main_screen/screen.dart';

class AuthController extends GetxController {
  /// TextEditingController untuk input
  final namaLengkapController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiPasswordController = TextEditingController();

  /// Toggle visibilitas password
  RxBool isPasswordHidden = true.obs;
  RxBool isKonfirmasiPasswordHidden = true.obs;

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleKonfirmasiPassword() {
    isKonfirmasiPasswordHidden.value = !isKonfirmasiPasswordHidden.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    konfirmasiPasswordController.dispose();
    super.onClose();
  }

  void nextLogin() {
    try {
      EasyLoading.show();
      AuthServices()
          .login(
            FormData({
              'email': emailController.text,
              'password': passwordController.text,
            }),
          )
          .then(
            (value) async => {
              print(value.body),
              if (value.statusCode == 200)
                {
                  GetStorage().write('pid', value.body['data']['pid']),
                  GetStorage().write(
                    'nama_lengkap',
                    value.body['data']['nama_lengkap'],
                  ),
                  GetStorage().write('email', value.body['data']['email']),
                  if (value.body['data']['pid'] == 1)
                    {Get.offAll(MainScreenAdmin())}
                  else
                    {Get.offAll(MainScreenMahasiswa())},
                  EasyLoading.showSuccess('Login Berhasil'),
                }
              else
                {EasyLoading.showError('${value.body['message']}')},
            },
          );
    } catch (e) {
      Get.snackbar(
        'Fitur Maitanace !!',
        'Fitur ini sedang dalam masa perbaikan.',
      );
    }
  }

  void nextRegister() {
    try {
      EasyLoading.show();
      AuthServices()
          .register(
            FormData({
              'nama_lengkap': namaLengkapController.text,
              'email': emailController.text,
              'password': passwordController.text,
            }),
          )
          .then(
            (value) async => {
              print(value.body),
              if (value.statusCode == 200)
                {
                  GetStorage().write('pid', value.body['data']['pid']),
                  GetStorage().write(
                    'nama_lengkap',
                    value.body['data']['nama_lengkap'],
                  ),
                  GetStorage().write('email', value.body['data']['email']),
                  Get.offAll(MainScreenMahasiswa()),
                  EasyLoading.showSuccess('Login Berhasil'),
                }
              else
                {EasyLoading.showError('${value.body['message']}')},
            },
          );
    } catch (e) {
      Get.snackbar(
        'Fitur Maitanace !!',
        'Fitur ini sedang dalam masa perbaikan.',
      );
    }
  }
}
