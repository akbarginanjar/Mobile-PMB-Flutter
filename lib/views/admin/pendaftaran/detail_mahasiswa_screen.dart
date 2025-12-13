import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/pendaftaran_controller.dart';

class DetailPendaftaranScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailPendaftaranScreen({super.key, required this.data});

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
        title: const Text("Detail Pendaftaran"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO PROFIL
            Center(
              child: SizedBox(
                height: 180,
                width: 180,
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blue.shade100,
                  child: data['foto'] == null
                      ? Text(
                          data["nama_lengkap"].substring(0, 1),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            '${data['foto']}',
                            width:
                                150, // harus sama dengan diameter CircleAvatar
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // NAMA
            Text(
              data['nama'] ?? "-",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),
            Text(
              "Pendaftar Baru",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // INFORMASI DETAIL
            if (data['nim'] != 'null') _detailItem("NIM", data['nim']),
            _detailItem("Email", data['email']),
            _detailItem("No HP", data['hp']),
            _detailItem("Program Studi", data['prodi']),
            _detailItem("Tanggal Daftar", data['tanggal']),
            _detailItem(
              "Status",
              data['status'] == '0'
                  ? "Belum diterima"
                  : data['status'] == '1'
                  ? "Diterima"
                  : "Ditolak",
              valueColor: data['status'] == '0'
                  ? Colors.orange
                  : data['status'] == '1'
                  ? Colors.green[800]
                  : Colors.red[800],
            ),

            const SizedBox(height: 30),

            // BUTTON AKSI
            if (data['status'] == '0')
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // LOGIC TERIMA
                        Get.defaultDialog(
                          title: "Konfirmasi",
                          middleText:
                              "Apakah Anda yakin ingin menerima mahasiswa ini?",
                          textCancel: "Batal",
                          textConfirm: "Ya, Terima",
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: "Keterangan",
                                  hintText: 'keterangan...',
                                  border: OutlineInputBorder(),
                                ),
                                controller: controller.keterangan.value,
                              ),
                            ],
                          ),
                          onConfirm: () {
                            Get.back();
                            controller.simpanAccMahasiswa(data['mid']);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Terima",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // LOGIC TOLAK
                        Get.defaultDialog(
                          title: "Konfirmasi",
                          middleText:
                              "Apakah Anda yakin ingin menolak mahasiswa ini?",
                          textCancel: "Batal",
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: "Keterangan",
                                  hintText: 'keterangan...',
                                  border: OutlineInputBorder(),
                                ),
                                controller: controller.keterangan.value,
                              ),
                            ],
                          ),
                          textConfirm: "Ya, Tolak",
                          onConfirm: () {
                            Get.back();
                            controller.simpanNonAccMahasiswa(data['mid']);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Tolak",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(String label, String? value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: TextStyle(
                fontSize: 15,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
