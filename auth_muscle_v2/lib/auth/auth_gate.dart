// auth_gate.dart

// TODO 1: Import package yang dibutuhkan
// - firebase_auth
// - cloud_firestore
// - material.dart
// - halaman: login_page, super_admin_page, admin_page, user_page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auth_muscle_v2/pages/admin_page.dart';
import 'package:auth_muscle_v2/pages/super_admin_page.dart';
import 'package:auth_muscle_v2/pages/user_page.dart';

// TODO 2: Buat StatelessWidget bernama AuthGate
// - Widget ini akan jadi "gerbang" utama aplikasi
// - Jangan pakai StatefulWidget, Stateless sudah cukup
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: builder
    );
  }
}

// TODO 3: Di dalam build(), gunakan StreamBuilder
// - Stream: FirebaseAuth.instance.authStateChanges()
// - Tujuan: cek apakah user sudah login atau belum

// TODO 4: Tangani kondisi loading auth
// - Jika connectionState == waiting
// - Tampilkan CircularProgressIndicator

// TODO 5: Jika user BELUM login
// - snapshot.hasData == false
// - Arahkan ke LoginPage
// - Jangan pakai Navigator, langsung return widget

// TODO 6: Jika user SUDAH login
// - Ambil uid dari snapshot.data!.uid

// TODO 7: Gunakan FutureBuilder untuk ambil data user dari Firestore
// - Collection: users
// - Document ID: uid
// - Tujuan: ambil role dan schoolId

// TODO 8: Tangani kondisi loading Firestore
// - Tampilkan CircularProgressIndicator

// TODO 9: Tangani error / data user tidak ditemukan
// - Jika document tidak ada
// - Tampilkan pesan error sederhana (Text)

// TODO 10: Ambil field role dari Firestore
// - role kemungkinan: super_admin, admin, teacher

// TODO 11: Lakukan routing berdasarkan role
// - Jika role == super_admin → SuperAdminPage
// - Jika role == admin → AdminPage
// - Jika role == teacher → UserPage

// TODO 12: Pastikan AuthGate hanya RETURN widget
// - Tidak boleh ada Navigator.push / pushReplacement
// - Semua routing berbasis return widget

// TODO 13 (opsional): Tambahkan logging/debug
// - print(uid)
// - print(role)
// - Berguna saat testing

// TODO 14 (opsional): Siapkan fallback page
// - Jika role tidak dikenal
// - Tampilkan Text("Role tidak valid")
