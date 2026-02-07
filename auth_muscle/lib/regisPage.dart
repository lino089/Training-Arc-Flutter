import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class regisPage extends StatefulWidget {
  const regisPage({super.key});

  @override
  State<regisPage> createState() => _regisPage();
}

class _regisPage extends State<regisPage> {
  // TODO: buat GlobalKey<FormState> untuk validasi form
  // TODO: buat variable String untuk menyimpan name
  // TODO: buat variable String untuk menyimpan email
  // TODO: buat variable String untuk menyimpan password
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  // TODO: buat function register() untuk proses pendaftaran user
  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String uid = userCredential.user!.uid;

        await FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'name': name,
          'email': email,
          'role': 'user',
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registrasi berhasil')));
      } on FirebaseAuthException catch (e) {
        String msg = 'Terjadi Kesalahan';

        if (e.code == 'email-already-in-use') {
          msg = 'Email sudah terdaftar';
        } else if (e.code == 'weak-password') {
          msg = 'Password terlalu lemah';
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrasi")),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Registrasi",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Form(
                // TODO: pasang GlobalKey<FormState> di Form
                key: formKey,
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // TODO: simpan value name ke variable
                          setState(() {
                            name = value;
                          });
                        },
                        validator: (value) {
                          // TODO: buat validasi name (tidak boleh kosong)
                          return value!.isEmpty ? 'Please Enter Name' : null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // TODO: simpan value email ke variable
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          // TODO: buat validasi email
                          return value!.isEmpty ? 'Please Enter Email' : null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // TODO: simpan value password ke variable
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          // TODO: buat validasi password
                          return value!.isEmpty
                              ? 'Please Enter Password'
                              : null;
                        },
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 15, left: 15),
                        child: MaterialButton(
                          // TODO: panggil function register()
                          onPressed: register,
                          minWidth: double.infinity,
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: Text("Register"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sudah Punya Akun?",
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
