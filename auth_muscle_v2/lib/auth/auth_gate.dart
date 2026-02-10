import 'package:auth_muscle_v2/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auth_muscle_v2/pages/admin_page.dart';
import 'package:auth_muscle_v2/pages/super_admin_page.dart';
import 'package:auth_muscle_v2/pages/user_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // auth_gate.dart
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authsnapshot) {
        if (authsnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!authsnapshot.hasData) {
          return const loginPage();
        }

        final uid = authsnapshot.data!.uid;

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, usersnapshot) {
            if (usersnapshot.hasError) {
              return Scaffold(
                body: Center(child: Text("Terjadi Kesalahan: ${usersnapshot.error}")),
              );
            }

            if (usersnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (!usersnapshot.hasData || !usersnapshot.data!.exists) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Data user Tidak ditemukan di Firestore"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: const Text("Logout & Coba Lagi"),
                      ),
                    ],
                  ),
                ),
              );
            }

            final data = usersnapshot.data!.data() as Map<String, dynamic>;
            final role = data['role'];

            if (role == 'super_admin') return const superAdminPage();
            if (role == 'admin') return const adminPage();
            if (role == 'user') return const userPage();


            return const Scaffold(
              body: Center(child: Text("Role tidak valid")),
            );
          },
        );
      },
    );
  }
}
