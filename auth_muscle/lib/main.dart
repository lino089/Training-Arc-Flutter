import 'package:flutter/material.dart';
import 'package:auth_muscle/loginPage.dart';
import 'package:auth_muscle/adminPage.dart';
import 'package:auth_muscle/userPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const loginPage();
        }
        return FutureBuilder<String>(
          future: getRole(snapshot.data!.uid),
          builder: (context, rolesnapshot) {
            if (rolesnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (rolesnapshot.data == 'admin') {
              return const dashboardAdmin();
            } else {
              return const dashboardUser();
            }
          },
        );
      },
      ),
    );
  }
  Future<String> getRole(String uid) async {
    return "admin";
  }
}
