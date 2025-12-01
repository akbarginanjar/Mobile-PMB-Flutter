import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/prodi_controller.dart';

class EditProdiScreen extends StatelessWidget {
  final String mpid;
  EditProdiScreen({super.key, required this.mpid});

  final controller = Get.put(ProdiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black38,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text("Edit Program Studi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // ===================== KODE PRODI ===========================
            const Text(
              "Kode Prodi",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: controller.kode,
              decoration: InputDecoration(
                filled: true,
                hintText: "Contoh: TI",
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

            const SizedBox(height: 20),

            // ===================== NAMA PRODI ===========================
            const Text(
              "Nama Prodi",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: controller.nama,
              decoration: InputDecoration(
                filled: true,
                hintText: "Contoh: Teknik Informatika",
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

            const SizedBox(height: 20),

            // ===================== NAMA FAKULTAS ===========================
            const Text(
              "Nama Fakultas",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: controller.fakultas,
              decoration: InputDecoration(
                filled: true,
                hintText: "Contoh: Fakultas Teknik",
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

            const SizedBox(height: 20),

            // ===================== JENJANG ===========================
            // const Text(
            //   "Jenjang",
            //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 6),

            // Obx(
            //   () => Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 14),
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade100,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: DropdownButtonHideUnderline(
            //       child: DropdownButton<String>(
            //         value: controller.jenjang.value,
            //         items: controller.jenjangList
            //             .map(
            //               (item) =>
            //                   DropdownMenuItem(value: item, child: Text(item)),
            //             )
            //             .toList(),
            //         onChanged: (value) {
            //           controller.jenjang.value = value!;
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 40),

            // ===================== BUTTON SIMPAN ==========================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.editProdi(mpid);
                },

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Simpan", style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 10),

            // ===================== BUTTON BATAL ==========================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Batal",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
