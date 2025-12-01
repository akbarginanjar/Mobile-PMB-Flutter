import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/auth_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 40),

              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Silakan masuk untuk melanjutkan",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              // ================= EMAIL FIELD =================
              const Text(
                "Email",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),

              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ================= PASSWORD FIELD =================
              const Text(
                "Password",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),

              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: controller.togglePassword,
                      child: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ================= BUTTON LOGIN =================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.nextLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
