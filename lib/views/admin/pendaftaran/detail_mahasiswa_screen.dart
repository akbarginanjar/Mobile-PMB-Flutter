import 'package:flutter/material.dart';

class DetailPendaftaranScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPendaftaranScreen({super.key, required this.data});

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
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: data['foto'] != null
                    ? NetworkImage(data['foto'])
                    : null,
                child: data['foto'] == null
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
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
            _detailItem("NIK", data['nik']),
            _detailItem("Email", data['email']),
            _detailItem("No HP", data['hp']),
            _detailItem("Program Studi", data['prodi']),
            _detailItem("Tanggal Daftar", data['tanggal']),
            _detailItem("Status", "Belum diterima", valueColor: Colors.orange),

            const SizedBox(height: 30),

            // BUTTON AKSI
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // LOGIC TERIMA
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Terima", style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // LOGIC TOLAK
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Tolak", style: TextStyle(fontSize: 16)),
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
