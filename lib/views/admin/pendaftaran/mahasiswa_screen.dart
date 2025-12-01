import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/mahasiswa_controller.dart'
    show MahasiswaDiterimaController;
import 'package:pmb_mobile/views/admin/pendaftaran/detail_mahasiswa_screen.dart';

class ListMahasiswaDiterimaScreen extends StatelessWidget {
  const ListMahasiswaDiterimaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MahasiswaDiterimaController>(
      init: MahasiswaDiterimaController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Mahasiswa",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              // 🔍 Kolom Search
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: controller.updateSearch,
                  decoration: InputDecoration(
                    hintText: "Cari nama, nim mahasiswa...",
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // LIST
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var list = controller.filteredMahasiswa;

                  if (list.isEmpty) {
                    return const Center(
                      child: Text(
                        "Tidak ada mahasiswa diterima",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var item = list[index];

                      return Card(
                        elevation: 0,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey[300]!, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onTap: () {
                            Get.to(
                              () => DetailPendaftaranScreen(
                                data: {
                                  "mid": "${item['mid']}",
                                  "nama": "${item['nama_lengkap']}",
                                  "nim": "${item['nim']}",
                                  "email": "${item['email']}",
                                  "hp": "${item['no_telp']}",
                                  "prodi": "${item['nama_prodi']}",
                                  "tanggal": "${item['create_time']}",
                                  "foto": "${item['upload_file']}",
                                  "status": "${item['status']}",
                                },
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: item['upload_file'] != null
                                ? NetworkImage(item['upload_file'])
                                : null,
                            child: item['upload_file'] == null
                                ? const Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                          title: Text(
                            item['nama_lengkap'] ?? "-",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['nim'] ?? "-"),
                              Text(item['nama_prodi'] ?? "-"),
                            ],
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: item['status'] == 0
                                  ? Colors.orange.shade100
                                  : item['status'] == 1
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item['status'] == 0
                                  ? 'Pending'
                                  : item['status'] == 1
                                  ? 'Diterima'
                                  : 'Ditolak',
                              style: TextStyle(
                                color: item['status'] == 0
                                    ? Colors.orange
                                    : item['status'] == 1
                                    ? Colors.green[800]
                                    : Colors.red[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
