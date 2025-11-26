import 'package:get/get.dart';

class PendaftaranController extends GetxController {
  // Semua data pendaftaran (misalnya dari API)
  RxList<Map<String, dynamic>> semuaPendaftar = [
    {
      "nama": "Ahmad",
      "no_pendaftaran": "PMB20250123",
      "prodi": "Sistem Informasi",
      "status": "Pending",
    },
    {
      "nama": "Budi",
      "no_pendaftaran": "PMB20250124",
      "prodi": "Teknik Informatika",
      "status": "Diverifikasi",
    },
    {
      "nama": "Siti",
      "no_pendaftaran": "PMB20250125",
      "prodi": "Manajemen Informatika",
      "status": "Pending",
    },
  ].obs;

  // Hanya data pending
  List<Map<String, dynamic>> get pendaftarBaru =>
      semuaPendaftar.where((m) => m["status"] == "Pending").toList();

  void goDetail(int index) {
    final data = pendaftarBaru[index];
    Get.snackbar("Detail", "Lihat data: ${data["nama"]}");
  }
}
