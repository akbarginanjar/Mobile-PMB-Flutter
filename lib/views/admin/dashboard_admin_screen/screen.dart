import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmb_mobile/controllers/dashboard_mahasiswa_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';
import 'package:pmb_mobile/views/admin/pendaftaran/pendaftaran_baru_screen.dart';
import 'package:pmb_mobile/views/admin/prodi_screen/screen.dart';
import 'package:pmb_mobile/views/home_screen/screen.dart';

class DashboardAdminScreen extends StatelessWidget {
  DashboardAdminScreen({super.key});

  final controller = Get.put(DashboardMahasiswaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // ---------------- HEADER ----------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Sealamat Datang",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Admin PMB",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    IconButton(
                      onPressed: () {
                        controller.loadDashboardAdmin({});
                      },
                      icon: Icon(Icons.refresh, size: 25),
                    ),
                    SizedBox(width: 10),

                    // Profile image
                    PopupMenuButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (value) {
                        if (value == "logout") {
                          GetStorage().remove('pid');
                          GetStorage().remove('nama_lengkap');
                          GetStorage().remove('email');
                          Get.offAll(HomeScreen());
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "logout",
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.red),
                              SizedBox(width: 10),
                              Text(
                                "Logout",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // CHILD AVATAR
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: primary,
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ---------------- GRID STATUS BOX ----------------
                Obx(() {
                  if (controller.isLoadingDashboard.value) {
                    return Center(
                      child: CircularProgressIndicator(color: primary),
                    );
                  }

                  if (controller.errorMessageDashboard.isNotEmpty) {
                    return Text(controller.errorMessageDashboard.value);
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _menuBox(
                        "Pendaftaran",
                        "${controller.listDashboard['pending'] ?? '0'}",
                        "",
                        Colors.orange.shade400,
                      ),
                      _menuBox(
                        "Mahasiswa",
                        "${controller.listDashboard['diterima'] ?? '0'}",
                        "",
                        Colors.blue.shade400,
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 30),

                // ---------------- TITLE ----------------
                Row(
                  children: [
                    const Text(
                      "Menu PMB",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ---------------- MENU BUTTONS ----------------
                _menuTile(
                  icon: Icons.person_add_alt_1,
                  title: "Pendaftaran",
                  subtitle: "Daftar calon mahasiswa",
                  onTap: () {
                    Get.to(PendaftaranBaruScreen());
                  },
                ),
                _menuTile(
                  icon: Icons.school,
                  title: "Program Studi",
                  subtitle: "Lihat daftar prodi",
                  onTap: () {
                    Get.to(ProdiScreen());
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------
  // WIDGET BOX
  // -----------------------------------------------------------
  Widget _menuBox(String title, String value, String subtitle, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------
  // MENU LIST TILE BUTTON
  // -----------------------------------------------------------
  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
