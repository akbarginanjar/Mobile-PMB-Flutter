import 'package:get/get.dart';

import 'package:flutter/material.dart';

class AuthController extends GetxController {
  /// TextEditingController untuk input
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
}
