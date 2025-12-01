import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/pendaftaran_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';

class FormPendaftaranScreen extends StatelessWidget {
  final controller = Get.put(PendaftaranController());

  FormPendaftaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Form Pendaftaran"),
        actions: [
          IconButton(
            onPressed: () {
              controller.loadCekPendaftaran();
            },
            icon: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoadingPendaftaran.value) {
            return Center(child: CircularProgressIndicator(color: primary));
          }

          if (controller.errorMessagePendaftaran.isNotEmpty) {
            return Text(controller.errorMessagePendaftaran.value);
          }
          return controller.dataPendaftar.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FOTO PROFIL
                    Center(
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.blue.shade100,
                        child:
                            controller.dataPendaftar[0]['upload_file'] == null
                            ? Text(
                                controller.dataPendaftar[0]["nama_lengkap"]
                                    .substring(0, 1),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : ClipOval(
                                child: Image.network(
                                  '${controller.dataPendaftar[0]['upload_file']}',
                                  width:
                                      40, // harus sama dengan diameter CircleAvatar
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // NAMA
                    Text(
                      controller.dataPendaftar[0]['nama_lengkap'] ?? "-",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),
                    Text(
                      "Pendaftar Baru",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),

                    // INFORMASI DETAIL
                    if (controller.dataPendaftar[0]['nim'] != 'null')
                      _detailItem("NIM", controller.dataPendaftar[0]['nim']),
                    _detailItem("Email", controller.dataPendaftar[0]['email']),
                    _detailItem(
                      "No HP",
                      controller.dataPendaftar[0]['no_telp'],
                    ),
                    _detailItem(
                      "Program Studi",
                      controller.dataPendaftar[0]['nama_prodi'],
                    ),
                    _detailItem(
                      "Tanggal Daftar",
                      controller.dataPendaftar[0]['create_time'],
                    ),
                    _detailItem(
                      "Status",
                      controller.dataPendaftar[0]['status'] == 0
                          ? "Belum diterima"
                          : controller.dataPendaftar[0]['status'] == 1
                          ? "Diterima"
                          : "Ditolak",
                      valueColor: controller.dataPendaftar[0]['status'] == 0
                          ? Colors.orange
                          : controller.dataPendaftar[0]['status'] == 1
                          ? Colors.green[800]
                          : Colors.red[800],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FOTO
                    Obx(() {
                      return controller.fileBytes.value == null
                          ? SizedBox(
                              width: 120,
                              height: 120,
                              child: Card(
                                margin: EdgeInsets.all(0),
                                color: Colors.grey.shade300,
                                child: Icon(Icons.person, size: 60),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.memory(
                                controller.fileBytes.value!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            );
                    }),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: controller.pickImage,
                        child: Text("Pilih Foto"),
                      ),
                    ),

                    SizedBox(height: 20),

                    // NAMA LENGKAP
                    TextField(
                      controller: controller.namaC.value,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),

                    // TANGGAL LAHIR
                    GestureDetector(
                      onTap: () => controller.pickTanggalLahir(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: controller.tglLahirC.value,
                          decoration: InputDecoration(
                            labelText: "Tanggal Lahir",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // ALAMAT
                    TextField(
                      controller: controller.alamatC.value,
                      decoration: InputDecoration(
                        labelText: "Alamat",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),

                    // NO TELP
                    TextField(
                      controller: controller.telpC.value,
                      decoration: InputDecoration(
                        labelText: "No Telp",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 15),

                    TextField(
                      controller: controller.semesterC.value,
                      decoration: InputDecoration(
                        labelText: "Semester Masuk",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),

                    // MPID
                    Obx(() {
                      if (controller.isLoadingProdi.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.errorMessageProdi.value.isNotEmpty) {
                        return Text(
                          controller.errorMessageProdi.value,
                          style: TextStyle(color: Colors.red),
                        );
                      }

                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Pilih Program Studi (MPID)",
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedMpid.value.isEmpty
                            ? null
                            : controller.selectedMpid.value,
                        items: controller.listProdi.map((prodi) {
                          return DropdownMenuItem<String>(
                            value: prodi['mpid']
                                .toString(), // nilai MPID yang tersimpan
                            child: Text(prodi['nama_prodi']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedMpid.value = value ?? "";
                          print(
                            "MPID dipilih: ${controller.selectedMpid.value}",
                          );
                        },
                      );
                    }),
                    SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: () {
                        controller.submit();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text("Kirim Pendaftaran"),
                    ),
                  ],
                );
        }),
      ),
    );
  }
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
            style: TextStyle(fontSize: 15, color: valueColor ?? Colors.black87),
          ),
        ),
      ],
    ),
  );
}
