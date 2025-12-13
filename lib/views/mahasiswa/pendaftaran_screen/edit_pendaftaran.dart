import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/pendaftaran_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';

class EditFormPendaftaranScreen extends StatelessWidget {
  final String? mid;
  final controller = Get.put(PendaftaranController());

  EditFormPendaftaranScreen({super.key, required this.mid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Form Pendaftaran"),
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FOTO
              Obx(() {
                return controller.fileBytes.value == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          controller.fileName.value.toString(),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
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
                    print("MPID dipilih: ${controller.selectedMpid.value}");
                  },
                );
              }),
              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  controller.editPendfataran(mid);
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
