import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Form(
              // TODO: tambahkan GlobalKey<FormState>
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      // TODO: simpan value email ke variable
                      onChanged: (value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Email' : null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      // TODO: simpan value password ke variable
                      onChanged: (value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Password' : null;
                      },
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MaterialButton(
                        onPressed: () {
                          // TODO: validasi form

                          // TODO: panggil FirebaseAuth signInWithEmailAndPassword

                          // TODO: handle error (try-catch)

                          // NOTE:
                          // setelah login sukses, JANGAN redirect di sini
                          // biarkan AuthStateListener yang handle redirect
                        },
                        minWidth: double.infinity,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
