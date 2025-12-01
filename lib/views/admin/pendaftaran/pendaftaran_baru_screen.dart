import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/pendaftaran_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              controller.loadPendaftaranBaru({});
            },
            icon: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: Obx(() {
        final data = controller.semuaPendaftar;

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
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator(color: primary));
            }

            if (controller.errorMessage.isNotEmpty) {
              return Text(controller.errorMessage.value);
            }
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
                        "mid": "${mhs['mid']}",
                        "nama": "${mhs['nama_lengkap']}",
                        "nim": "${mhs['nim']}",
                        "email": "${mhs['email']}",
                        "hp": "${mhs['no_telp']}",
                        "prodi": "${mhs['nama_prodi']}",
                        "tanggal": "${mhs['create_time']}",
                        "foto": "${mhs['upload_file']}",
                        "status": "${mhs['status']}",
                      },
                    ),
                  )!.then((result) {
                    if (result == true) {
                      controller.loadPendaftaranBaru({});
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.blue.shade100,
                        child: mhs['upload_file'] == null
                            ? Text(
                                mhs["nama_lengkap"].substring(0, 1),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : ClipOval(
                                child: Image.network(
                                  '${mhs['upload_file']}',
                                  width:
                                      52, // harus sama dengan diameter CircleAvatar
                                  height: 52,
                                  fit: BoxFit.cover,
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
                              mhs["nama_lengkap"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "Tgl Pendaftaran: ${mhs["create_time"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              "Prodi: ${mhs["nama_prodi"]}",
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
                                color: mhs['status'] == 0
                                    ? Colors.orange.withOpacity(0.15)
                                    : mhs['status'] == 1
                                    ? Colors.green.withOpacity(0.15)
                                    : Colors.red.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                mhs['status'] == 0
                                    ? "Belum Diterima"
                                    : mhs['status'] == 1
                                    ? "Diterima"
                                    : "Ditolak",
                                style: TextStyle(
                                  color: mhs['status'] == 0
                                      ? Colors.orange
                                      : mhs['status'] == 1
                                      ? Colors.green
                                      : Colors.red,
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
                        onPressed: () {},
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
