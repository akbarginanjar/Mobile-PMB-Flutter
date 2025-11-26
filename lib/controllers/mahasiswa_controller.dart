import 'package:get/get.dart';

class MahasiswaDiterimaController extends GetxController {
  var searchText = "".obs;

  // Data dummy – nanti bisa ganti dari API
  var mahasiswa = [
    {
      "nama": "Budi Santoso",
      "prodi": "Informatika",
      "tanggal": "22 Nov 2025",
      "foto": null,
    },
    {
      "nama": "Siti Aminah",
      "prodi": "Hukum",
      "tanggal": "23 Nov 2025",
      "foto": null,
    },
  ].obs;

  List<Map<String, dynamic>> get filteredMahasiswa {
    if (searchText.isEmpty) return mahasiswa;
    return mahasiswa
        .where(
          (m) => m['nama'].toString().toLowerCase().contains(
            searchText.toLowerCase(),
          ),
        )
        .toList();
  }

  void updateSearch(String value) {
    searchText.value = value;
  }
}
