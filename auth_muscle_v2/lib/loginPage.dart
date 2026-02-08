import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "UID",
                        hintText: "Enter UID",
                        prefixIcon: Icon(Icons.perm_identity),
                        border: OutlineInputBorder()
                      ),
                      onChanged: (value) {
                        
                      },
                      validator: (value) {
                        
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder()  
                      ),
                      onChanged: (value) {
                        
                      },
                      validator: (value) {
                        
                      },
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 15, right: 15) ,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: double.infinity,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text("Login"),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        
                      }, 
                      child: Text(
                        "Buat Akun Sekolah",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold
                        ),
                        )
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
