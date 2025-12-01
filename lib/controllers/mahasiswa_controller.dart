import 'package:get/get.dart';
import 'package:pmb_mobile/utils/base.dart';

class MahasiswaDiterimaController extends GetxController {
  var searchText = "".obs;

  var mahasiswa = <Map<String, dynamic>>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMahasiswa(); // load hanya sekali
  }

  // 🚀 HIT API sekali
  Future<void> fetchMahasiswa() async {
    try {
      isLoading.value = true;

      Response res = await GetConnect().get('${Base.url}/api/mahasiswa-all');

      if (res.statusCode == 200 && res.body != null) {
        mahasiswa.value = List<Map<String, dynamic>>.from(res.body['results']);
      } else {
        mahasiswa.clear();
      }
    } catch (e) {
      mahasiswa.clear();
      print("ERROR fetchMahasiswa: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 🔍 Search LOKAL (nama + nim)
  List<Map<String, dynamic>> get filteredMahasiswa {
    if (searchText.value.isEmpty) return mahasiswa;

    final s = searchText.value.toLowerCase();

    return mahasiswa.where((m) {
      final nama = (m['nama_lengkap'] ?? "").toString().toLowerCase();
      final nim = (m['nim'] ?? "").toString().toLowerCase();

      return nama.contains(s) || nim.contains(s);
    }).toList();
  }

  // 🔧 update search tanpa hit API
  void updateSearch(String value) {
    searchText.value = value;
  }
}
