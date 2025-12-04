import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pmb_mobile/services/mahasiswa_service.dart';
import 'package:path/path.dart';
import 'package:pmb_mobile/services/prodi_service.dart';
import 'package:pmb_mobile/utils/base.dart';
import 'package:pmb_mobile/views/mahasiswa/main_screen/screen.dart';

class PendaftaranController extends GetxController {
  // Semua data pendaftaran (misalnya dari API)
  // RxList<Map<String, dynamic>> semuaPendaftar = [
  //   {
  //     "nama": "Ahmad",
  //     "no_pendaftaran": "PMB20250123",
  //     "prodi": "Sistem Informasi",
  //     "status": "Pending",
  //   },
  //   {
  //     "nama": "Budi",
  //     "no_pendaftaran": "PMB20250124",
  //     "prodi": "Teknik Informatika",
  //     "status": "Diverifikasi",
  //   },
  //   {
  //     "nama": "Siti",
  //     "no_pendaftaran": "PMB20250125",
  //     "prodi": "Manajemen Informatika",
  //     "status": "Pending",
  //   },
  // ].obs;

  @override
  void onInit() {
    loadPendaftaranBaru({});
    loadProdi({});
    loadCekPendaftaran();
    super.onInit();
  }

  var isLoadingPendaftaran = false.obs;
  var dataPendaftar = [].obs; // Sesuaikan tipe jika ada model
  var errorMessagePendaftaran = ''.obs;

  Future<void> loadCekPendaftaran() async {
    try {
      isLoadingPendaftaran.value = true;
      errorMessagePendaftaran.value = '';

      final response = await MahasiswaService().detailCekMahasiswa(
        GetStorage().read('pid').toString(),
      );
      print(response.body);

      if (response.statusCode == 200) {
        dataPendaftar.value =
            response.body['results']; // Sesuaikan jika body punya struktur
      } else {
        errorMessagePendaftaran.value = "Error ${response.statusCode}";
      }
    } catch (e) {
      errorMessagePendaftaran.value = e.toString();
    } finally {
      isLoadingPendaftaran.value = false;
    }
  }

  var isLoading = false.obs;
  var semuaPendaftar = [].obs; // Sesuaikan tipe jika ada model
  var errorMessage = ''.obs;

  Future<void> loadPendaftaranBaru(Map<String, dynamic> params) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await MahasiswaService().listPendaftaran(params);
      print(response.body);

      if (response.statusCode == 200) {
        semuaPendaftar.value =
            response.body['results']; // Sesuaikan jika body punya struktur
      } else {
        errorMessage.value = "Error ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // FORM FIELD CONTROLLERS
  Rx<TextEditingController> namaC = TextEditingController().obs;
  Rx<TextEditingController> tglLahirC = TextEditingController().obs;
  Rx<TextEditingController> alamatC = TextEditingController().obs;
  Rx<TextEditingController> telpC = TextEditingController().obs;
  Rx<TextEditingController> mpidC = TextEditingController().obs;
  Rx<TextEditingController> semesterC = TextEditingController().obs;
  Rx<TextEditingController> pidC = TextEditingController().obs;

  void pickTanggalLahir(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      tglLahirC.value.text = picked.toIso8601String().substring(0, 10);
      update();
    }
  }

  // FILE (support Web)
  Rx<Uint8List?> fileBytes = Rx<Uint8List?>(null);
  Rx<String?> fileName = Rx<String?>(null);

  // PICK FILE
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true, // penting untuk WEB
    );

    if (result != null) {
      fileBytes.value = result.files.first.bytes;
      fileName.value = result.files.first.name;
      update();
    }
  }

  var isLoadingProdi = false.obs;
  var listProdi = [].obs; // Sesuaikan tipe jika ada model
  var errorMessageProdi = ''.obs;

  // STATE UNTUK MPID YANG DIPILIH
  RxString selectedMpid = ''.obs;

  Future<void> loadProdi(Map<String, dynamic> params) async {
    try {
      isLoadingProdi.value = true;
      errorMessage.value = '';

      final response = await ProdiService().prodi(params);
      print(response.body);

      if (response.statusCode == 200) {
        listProdi.value =
            response.body['data']; // Sesuaikan jika body punya struktur
      } else {
        errorMessageProdi.value = "Error ${response.statusCode}";
      }
    } catch (e) {
      errorMessageProdi.value = e.toString();
    } finally {
      isLoadingProdi.value = false;
    }
  }

  // KIRIM DATA
  Future<void> submit() async {
    print(namaC.value.text);
    print(tglLahirC.value.text);
    print(alamatC.value.text);
    print(telpC.value.text);
    print(selectedMpid);
    print(pidC.value.text);
    print(GetStorage().read('pid'));
    EasyLoading.show(status: 'Mohon tunggu...');
    final url = Uri.parse("${Base.url}/api/mahasiswa-pendaftaran");

    var request = http.MultipartRequest("POST", url);

    request.fields['nama_lengkap'] = namaC.value.text;
    request.fields['tanggal_lahir'] = tglLahirC.value.text;
    request.fields['alamat'] = alamatC.value.text;
    request.fields['no_telp'] = telpC.value.text;
    request.fields['mpid'] = selectedMpid.value;
    request.fields['semester_masuk'] = semesterC.value.text;
    request.fields['pid'] = GetStorage().read('pid').toString();

    // HANDLE FILE UNTUK WEB + MOBILE
    if (fileBytes.value != null && fileName.value != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'upload_file',
          fileBytes.value!,
          filename: basename(fileName.value!),
        ),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Formulir anda berhasil terkirim');
      Get.off(DaftarBerhasil());
    } else {
      Get.snackbar("Error", "Gagal mendaftar");
    }
  }

  void simpanAccMahasiswa(mid) {
    try {
      EasyLoading.show();
      MahasiswaService()
          .accMahasiswa(mid, {})
          .then(
            (value) async => {
              print(value.body),
              if (value.statusCode == 200)
                {
                  Get.back(result: true),
                  EasyLoading.showSuccess('Berhasil Diterima'),
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

  void simpanNonAccMahasiswa(mid) {
    try {
      EasyLoading.show();
      MahasiswaService()
          .nonAccMahasiswa(mid, {})
          .then(
            (value) async => {
              print(value.body),
              if (value.statusCode == 200)
                {
                  Get.back(result: true),
                  EasyLoading.showSuccess('Berhasil Ditolak'),
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
}

class DaftarBerhasil extends StatelessWidget {
  const DaftarBerhasil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.green[800], size: 100),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Berhasil Daftar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Formulir anda berhasil terkirim\ntunggu konfirmasi dari admin, dan lihat\nstatus pendaftaran anda.',
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(MainScreenMahasiswa());
              },
              child: Text('Kembali ke home'),
            ),
          ),
        ],
      ),
    );
  }
}
