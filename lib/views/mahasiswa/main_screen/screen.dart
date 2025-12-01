import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/main_controller.dart';
import 'package:pmb_mobile/utils/theme.dart';
import 'package:pmb_mobile/views/mahasiswa/dashboard_mahasiswa_screen/screen.dart';
import 'package:pmb_mobile/views/home_screen/screen.dart';
import 'package:pmb_mobile/views/mahasiswa/pendaftaran_screen/screen.dart';

class MainScreenMahasiswa extends StatefulWidget {
  const MainScreenMahasiswa({super.key});

  @override
  State<MainScreenMahasiswa> createState() => _MainScreeMahasiswaState();
}

class _MainScreeMahasiswaState extends State<MainScreenMahasiswa> {
  final List<Widget> _screens = [
    DashboardMahasiswaScreen(),
    FormPendaftaranScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (value) {
        return Scaffold(
          body: _screens[value.index],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            iconSize: 25,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,

            currentIndex: value.index,
            onTap: (v) => value.changeIndex(v),

            // Warna item aktif & tidak aktif
            selectedItemColor: primary,
            unselectedItemColor: Colors.grey,

            // Icon aktif & tidak aktif
            selectedIconTheme: IconThemeData(color: primary, size: 28),
            unselectedIconTheme: const IconThemeData(
              color: Colors.grey,
              size: 25,
            ),

            // Teks aktif & tidak aktif
            selectedLabelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_open),
                label: 'Pendaftaran',
              ),
            ],
          ),
        );
      },
    );
  }
}
