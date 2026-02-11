import 'package:auth_muscle_v2/auth/auth_gate.dart';
import 'package:auth_muscle_v2/pages/regisPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  final TextEditingController userIdControler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final TextEditingController npsnControler = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> login() async {
    final String npsn = npsnControler.text.trim(); // Ambil input NPSN
    final String userId = userIdControler.text.trim();
    final String password = passwordControler.text.trim();

    if (key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final schoolQuery = await FirebaseFirestore.instance
            .collection('schools')
            .where('npsn', isEqualTo: npsn)
            .limit(1)
            .get();

        if (schoolQuery.docs.isEmpty) {
          throw "Sekolah dengan NPSN tersebut tidak ditemukan";
        }
        // final schoolId = schoolQuery.docs.first.id;
        final schoolId = schoolQuery.docs.first.id;

        final query = await FirebaseFirestore.instance
            .collection('users')
            .where('userId', isEqualTo: userId)
            .where('schoolId', isEqualTo: schoolId)
            .limit(1)
            .get();

        if (query.docs.isEmpty) {
          throw 'User ID tidak ditemukan di sekolah ini';
        }

        final userDoc = query.docs.first;
        final email = userDoc['email'];
        final bool isActive = userDoc['isActive'] ?? false;

        if (!isActive) {
          throw 'Akun belum aktif. hubungi admin.';
        }
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login Berhasil")));
        }

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false
        );


      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Terjadi kesalahan saat login')),
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
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Form(
                key: key,
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    TextFormField(
                      controller: npsnControler,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NPSN",
                        hintText: "Enter NPSN",
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NPSN tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: userIdControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "User ID",
                        hintText: "Contoh: A-0000 / T-0003",
                        prefixIcon: Icon(Icons.perm_identity),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'User Id Tidak Boleh Kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordControler,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Tidak Boleh Kosong';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 15, right: 15),
                      child: MaterialButton(
                        onPressed: isLoading ? null : () => login(),
                        minWidth: double.infinity,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Login"),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => regisPage()),
                        );
                      },
                      child: Text(
                        "Buat Akun Sekolah",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
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
    npsnControler.dispose();
    userIdControler.dispose();
    passwordControler.dispose();
    super.dispose();
  }
}
