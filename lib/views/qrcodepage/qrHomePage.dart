import 'package:flutter/material.dart';

import 'package:student_attendance_control/theme/themeColor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:student_attendance_control/views/qrcodepage/qrPage.dart';

import '../../model/user_model.dart';
import '../../service/user_service.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({super.key});

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  int currentIndex = 0;
  List screens = [
    const qrcodepage(),
    const lessonhistorypage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 25,
        selectedFontSize: 17,
        unselectedFontSize: 13,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "QR",
            //backgroundColor: AppColors.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.history),
            label: "Geçmiş",
            //backgroundColor: AppColors.primary,
          )
        ],
      ),
    );
  }
}

class qrcodepage extends StatelessWidget {
  const qrcodepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: AppColors.primary,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Özcan Fatih Can",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ), //Öğrenci İsmi
                  Text(
                    "Bilgisayar Mühendisliği",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ), //Bölüm ismi
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => qrPageScreen()),
                      );
                    },
                    icon: new Icon(MdiIcons.qrcodeScan),
                    color: AppColors.primary,
                    iconSize: 90,
                  ),
                  Text(
                    "QR kodunu taramak için tıklayın",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class lessonhistorypage extends StatelessWidget {
  const lessonhistorypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: AppColors.primary,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ders Geçmişi",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ), //Öğrenci İsmi
                ],
              ),
            ),
          ),
        ),
        Expanded(flex: 7, child: Container()),
      ],
    );
  }
}
