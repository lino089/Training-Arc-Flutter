import 'package:flutter/material.dart';
import 'package:auth_muscle/loginPage.dart';
import 'package:flutter/material.dart';
// TODO: import firebase_core
// TODO: import auth gate / auth state listener widget
// NOTE: loginPage JANGAN dipanggil langsung di main

void main() async {
  // TODO: pastikan WidgetsFlutterBinding diinisialisasi

  // TODO: inisialisasi Firebase

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: matikan debug banner (optional)

      // TODO: ganti home dari loginPage ke AuthGate / AuthWrapper
      // home: loginPage(),

      // TODO: AuthGate akan menentukan:
      // - login page
      // - admin dashboard
      // - guru dashboard
    );
  }
}
