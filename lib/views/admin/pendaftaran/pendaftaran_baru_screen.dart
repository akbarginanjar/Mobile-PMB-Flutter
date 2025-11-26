import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/pendaftaran_controller.dart';
import 'package:pmb_mobile/views/admin/pendaftaran/detail_mahasiswa_screen.dart';

class PendaftaranBaruScreen extends StatelessWidget {
  PendaftaranBaruScreen({super.key});

  final controller = Get.put(PendaftaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black38,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text("Pendaftar Baru"),
      ),

      body: Obx(() {
        final data = controller.pendaftarBaru;

        if (data.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada pendaftar baru.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final mhs = data[index];

            return Card(
              elevation: 0,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Get.to(
                    () => DetailPendaftaranScreen(
                      data: {
                        "nama": "Budi Santoso",
                        "nik": "123456789",
                        "email": "budi@gmail.com",
                        "hp": "0812345678",
                        "prodi": "Informatika",
                        "tanggal": "22 November 2025",
                        "foto": null,
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          mhs["nama"].substring(0, 1),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Data Mahasiswa
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mhs["nama"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "Nomor Pendaftaran: ${mhs["no_pendaftaran"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              "Prodi: ${mhs["prodi"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Badge Status
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Belum Diterima",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tombol Detail
                      IconButton(
                        onPressed: () => controller.goDetail(index),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
