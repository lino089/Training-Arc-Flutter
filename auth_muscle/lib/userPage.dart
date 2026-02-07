import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class dashboardUser extends StatelessWidget {
  const dashboardUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
        actions: <Widget>[
          IconButton(
            onPressed: FirebaseAuth.instance.signOut, 
            icon: Icon(Icons.logout)
          )
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("User Page"),
          ],
        ),
      ),
    );
  }
}
