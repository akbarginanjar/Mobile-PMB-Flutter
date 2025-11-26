import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/prodi_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';
import 'package:pmb_mobile/views/admin/prodi_screen/tambah_prodi_screen.dart';

class ProdiScreen extends StatelessWidget {
  ProdiScreen({super.key});

  final controller = Get.put(ProdiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black38,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text("Data Program Studi"),
        actions: [],
      ),

      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
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
                        prodi["kode"],
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
                            prodi["nama"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Jenjang: ${prodi["jenjang"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Button Edit
                    IconButton(
                      onPressed: () => controller.editProdi(index),
                      icon: Icon(Icons.edit, color: Colors.grey[400]),
                    ),

                    // Button Hapus
                    IconButton(
                      onPressed: () => controller.deleteProdi(index),
                      icon: Icon(Icons.delete, color: Colors.red[700]),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: ElevatedButton(
          onPressed: () {
            Get.to(TambahProdiScreen());
          },
          child: Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
