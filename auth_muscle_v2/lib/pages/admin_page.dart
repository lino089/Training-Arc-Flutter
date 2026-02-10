import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class adminPage extends StatelessWidget {
  const adminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
        actions: <Widget>[
          IconButton(
            onPressed: FirebaseAuth.instance.signOut, 
            icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Center(
        child: Text("Admin page"),
      ),
    );
  }
}
