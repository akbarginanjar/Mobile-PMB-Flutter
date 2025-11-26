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
                    hintText: "Cari nama mahasiswa...",
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
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: item['foto'] != null
                                ? NetworkImage(item['foto'])
                                : null,
                            child: item['foto'] == null
                                ? const Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                          title: Text(
                            item['nama'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(item['prodi']),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Diterima",
                              style: TextStyle(
                                color: Colors.green,
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
