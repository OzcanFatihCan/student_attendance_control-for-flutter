import 'package:flutter/material.dart';
import 'package:student_attendance_control/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Studen_attendance",
      home: LoginPage(),
    );
  }
}
