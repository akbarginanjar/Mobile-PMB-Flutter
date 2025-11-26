import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProdiController extends GetxController {
  RxList<Map<String, dynamic>> listProdi = [
    {"kode": "TI", "nama": "Teknik Informatika", "jenjang": "S1"},
    {"kode": "SI", "nama": "Sistem Informasi", "jenjang": "S1"},
  ].obs;

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();

  RxString jenjang = "S1".obs;

  List<String> jenjangList = ["D3", "D4", "S1", "S2", "S3"];

  void simpanProdi() {
    if (kode.text.isEmpty || nama.text.isEmpty) {
      Get.snackbar("Error", "Semua field harus diisi!");
      return;
    }

    Get.snackbar("Berhasil", "Prodi berhasil ditambahkan!");

    Get.back();
  }

  void editProdi(int index) {
    Get.snackbar("Edit", "Edit Prodi: ${listProdi[index]["nama"]}");
  }

  void deleteProdi(int index) {
    listProdi.removeAt(index);
    Get.snackbar("Hapus", "Data berhasil dihapus");
  }
}
