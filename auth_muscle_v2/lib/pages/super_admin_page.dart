import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class superAdminPage extends StatelessWidget {
  const superAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Admin Page"),
        actions: <Widget>[
          IconButton(
            onPressed: FirebaseAuth.instance.signOut, 
            icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Center(child: Text("Super Admin")),
    );
    // A-0001 | admin123
    // 20202317 | ADMIN-01 | kasihan123
  }
}
