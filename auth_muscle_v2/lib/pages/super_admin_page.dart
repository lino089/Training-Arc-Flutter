import 'package:flutter/material.dart';

class superAdminPage extends StatelessWidget {
  const superAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Admin Page"),
      ),
      body: Center(child: Text("Super Admin")),
    );
  }
}
