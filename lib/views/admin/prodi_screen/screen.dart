import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/prodi_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';
import 'package:pmb_mobile/views/admin/prodi_screen/edit_prodi_screen.dart';
import 'package:pmb_mobile/views/admin/prodi_screen/tambah_prodi_screen.dart';

class ProdiScreen extends StatelessWidget {
  ProdiScreen({super.key});

  final controller = Get.put(ProdiController());

  @override
  Widget build(BuildContext context) {
    controller.loadProdi({});
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black38,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text("Data Program Studi"),
        actions: [
          IconButton(
            onPressed: () {
              controller.loadProdi({});
            },
            icon: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: primary));
        }

        if (controller.errorMessage.isNotEmpty) {
          return Text(controller.errorMessage.value);
        }
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

                    // Button Edit
                    IconButton(
                      onPressed: () {
                        controller.kode.text = prodi["kode_prodi"];
                        controller.nama.text = prodi["nama_prodi"];
                        controller.fakultas.text = prodi["fakultas"];

                        Get.to(
                          () => EditProdiScreen(mpid: prodi["mpid"].toString()),
                        )!.then((result) {
                          if (result == true) {
                            controller.loadProdi({});
                          }
                        });
                      },
                      icon: Icon(Icons.edit, color: Colors.grey[400]),
                    ),

                    // // Button Hapus
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.delete, color: Colors.red[700]),
                    // ),
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
            controller.nama.clear();
            controller.kode.clear();
            controller.fakultas.clear();
            Get.to(() => TambahProdiScreen())!.then((result) {
              if (result == true) {
                controller.loadProdi({});
              }
            });
          },
          child: Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
