import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class regisPage extends StatefulWidget {
  const regisPage({super.key});

  @override
  State<regisPage> createState() => _regisPage();
}

class _regisPage extends State<regisPage> {
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
                          setState(() {});
                        },
                        validator: (value) {},
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'email',
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {},
                        validator: (value) {},
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {},
                        validator: (value) {},
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 15, left: 15),
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: double.infinity,
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: Text("Login"),
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
                            fontWeight: FontWeight.bold
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
