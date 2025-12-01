import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/services/mahasiswa_service.dart';
import 'package:pmb_mobile/services/prodi_service.dart';

class DashboardMahasiswaController extends GetxController {
  final ProdiService service = ProdiService();

  @override
  void onInit() {
    loadProdi({});
    loadDashboardAdmin({});
    super.onInit();
  }

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

  var isLoadingDashboard = false.obs;
  var listDashboard = {}.obs; // Sesuaikan tipe jika ada model
  var errorMessageDashboard = ''.obs;

  Future<void> loadDashboardAdmin(Map<String, dynamic> params) async {
    try {
      isLoadingDashboard.value = true;
      errorMessageDashboard.value = '';

      final response = await MahasiswaService().dashboardAdmin(params);
      print(response.body);

      if (response.statusCode == 200) {
        listDashboard.value =
            response.body['results']; // Sesuaikan jika body punya struktur
      } else {
        errorMessageDashboard.value = "Error ${response.statusCode}";
      }
    } catch (e) {
      errorMessageDashboard.value = e.toString();
    } finally {
      isLoadingDashboard.value = false;
    }
  }
}
