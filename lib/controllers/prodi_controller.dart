import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/services/prodi_service.dart';

class ProdiController extends GetxController {
  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController fakultas = TextEditingController();

  RxString jenjang = "S1".obs;

  List<String> jenjangList = ["D3", "D4", "S1", "S2", "S3"];

  final ProdiService service = ProdiService();

  var isLoading = false.obs;
  var listProdi = [].obs; // Sesuaikan tipe jika ada model
  var errorMessage = ''.obs;

  Future<void> loadProdi(Map<String, dynamic> params) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await service.prodi(params);
      print(response.body);

      if (response.statusCode == 200) {
        listProdi.value =
            response.body['data']; // Sesuaikan jika body punya struktur
      } else {
        errorMessage.value = "Error ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void simpanProdi() {
    try {
      EasyLoading.show();
      ProdiService()
          .tambahProdi(
            FormData({
              'kode_prodi': kode.text,
              'nama_prodi': nama.text,
              'fakultas': fakultas.text,
            }),
          )
          .then(
            (value) async => {
              print(value.body),
              if (value.statusCode == 200)
                {
                  Get.back(result: true),
                  EasyLoading.showSuccess('Berhasil Ditambahkan'),
                }
              else
                {EasyLoading.showError('${value.body['message']}')},
            },
          );
    } catch (e) {
      Get.snackbar(
        'Fitur Maitanace !!',
        'Fitur ini sedang dalam masa perbaikan.',
      );
    }
  }

  void editProdi(String mpid) {
    try {
      EasyLoading.show();

      ProdiService()
          .tambahProdi(
            FormData({
              'mpid': mpid,
              'kode_prodi': kode.text,
              'nama_prodi': nama.text,
              'fakultas': fakultas.text,
            }),
          )
          .then(
            (value) async => {
              print(value.body),
              if (value.statusCode == 200)
                {
                  Get.back(result: true),
                  EasyLoading.showSuccess('Berhasil Diedit'),
                }
              else
                {EasyLoading.showError('${value.body['message']}')},
            },
          );
    } catch (e) {
      Get.snackbar(
        'Fitur Maintenance !!',
        'Fitur ini sedang dalam masa perbaikan.',
      );
    }
  }
}
