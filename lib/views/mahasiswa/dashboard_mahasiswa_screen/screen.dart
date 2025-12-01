import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmb_mobile/controllers/dashboard_mahasiswa_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';
import 'package:pmb_mobile/views/home_screen/screen.dart';

// ignore: must_be_immutable
class DashboardMahasiswaScreen extends StatelessWidget {
  DashboardMahasiswaScreen({super.key});

  final controller = Get.put(DashboardMahasiswaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // ---------------- HEADER ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sealamat Datang",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${GetStorage().read('nama_lengkap')}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

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
              ),

              const SizedBox(height: 20),

              CarouselSlider(
                items:
                    [
                      'assets/images/banner1.jpeg',
                      'assets/images/banner2.jpeg',
                    ].map((path) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          path,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),

                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 5),
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- TITLE ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Semua Prodi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.loadProdi({});
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(color: primary),
                    );
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return Text(controller.errorMessage.value);
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: controller.listProdi.length,
                    itemBuilder: (context, index) {
                      final prodi = controller.listProdi[index];

                      return Card(
                        elevation: 0,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              // Badge Singkatan Prodi
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  prodi["kode_prodi"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),

                              // Nama & Jenjang
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      prodi["nama_prodi"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Fakultas: ${prodi["fakultas"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
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
