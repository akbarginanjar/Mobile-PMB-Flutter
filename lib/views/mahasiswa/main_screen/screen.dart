import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmb_mobile/controllers/main_controller.dart';
import 'package:pmb_mobile/views/home_screen/screen.dart';

class MainScreenMahasiswa extends StatefulWidget {
  const MainScreenMahasiswa({super.key});

  @override
  State<MainScreenMahasiswa> createState() => _MainScreenMahasiswaState();
}

class _MainScreenMahasiswaState extends State<MainScreenMahasiswa> {
  final List<Widget> _screens = [const HomeScreen(), const HomeScreen()];

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
            onTap: (v) {
              value.changeIndex(v);
            },
            currentIndex: value.index,
            enableFeedback: true,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note),
                label: 'Pendaftaran',
              ),
            ],
          ),
        );
      },
    );
  }
}
