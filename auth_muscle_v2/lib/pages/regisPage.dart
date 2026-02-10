import 'package:auth_muscle_v2/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// // TODO 1: Import firebase_auth dan cloud_firestore

class regisPage extends StatefulWidget {
  const regisPage({super.key});

  @override
  State<regisPage> createState() => _regisPage();
}

class _regisPage extends State<regisPage> {
  // // TODO 2: Buat TextEditingController untuk npsn, schoolName, address, email, dan password
  // // TODO 3: Buat GlobalKey<FormState> dan variabel bool isLoading = false
  final TextEditingController npsnController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isLoading = false;

  // // TODO 4: Buat fungsi Future<void> register() async { ... }
  // Di dalam fungsi ini, jalankan alur berikut:
  // a. Cek validasi form.
  // b. Daftarkan email & password ke FirebaseAuth (createUserWithEmailAndPassword).
  // c. Setelah dapat UID, buat dokumen baru di koleksi 'schools' dengan data NPSN, nama, dll.
  // d. Simpan juga data user ke koleksi 'users' dengan role 'admin' dan sertakan 'schoolId' & 'userId'.
  // e. Terakhir, buat mapping di koleksi 'login_map' dengan ID: "${schoolId}_${userId}".
  Future<void> register() async {
    final String password = passwordController.text.trim();
    final String schoolName = schoolNameController.text.trim();
    final String address = addressController.text.trim();
    final String email = emailController.text.trim();
    final String npsn = npsnController.text.trim();

    if (key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String uid = userCredential.user!.uid;

        DocumentReference schoolRef = await FirebaseFirestore.instance
            .collection('schools')
            .add({
              'npsn': npsn,
              'name': schoolName,
              'address': address,
              'isActive': true,
              'superAdminUid': uid,
              'createAt': FieldValue.serverTimestamp(),
            });

        String schoolId = schoolRef.id;
        String userId = "ADMIN-01";

        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'userId': userId,
          'schoolId': schoolId,
          'email': email,
          'role': 'super_admin',
          'isActive': true,
          'createAt': FieldValue.serverTimestamp(),
        });

        await FirebaseFirestore.instance
            .collection('login_map')
            .doc("${schoolId}_$userId")
            .set({'email': email, 'schoolId': schoolId, 'userId': userId});

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registrasi Berhasil!, Silahkan Login"),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const loginPage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Terjadi kesalahan")),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Page")),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: npsnController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NPSN",
                        hintText: "Enter NPSN",
                        prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "NPSN Wajib Diisi";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: schoolNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Name School",
                        hintText: "Enter School Name",
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama Sekolah Wajib Diisi";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Address",
                        hintText: "Enter Address",
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Alamat Wajib Diisi";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email Wajib Diisi";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password Wajib Diisi";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 15, right: 15),
                      child: MaterialButton(
                        // // TODO 16: Panggil fungsi register() dan tampilkan loading jika isLoading true
                        onPressed: register,
                        minWidth: double.infinity,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text("Register"),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => loginPage()),
                        );
                      },
                      child: Text(
                        "Sudah Punya Akun",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    npsnController.dispose();
    passwordController.dispose();
    emailController.dispose();
    schoolNameController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
