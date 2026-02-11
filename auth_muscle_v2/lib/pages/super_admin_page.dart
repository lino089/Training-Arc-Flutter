import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class superAdminPage extends StatefulWidget {
  const superAdminPage({super.key});

  @override
  State<superAdminPage> createState() => _superAdminPage();
}

class _superAdminPage extends State<superAdminPage> {
  // // TODO 1: Buat GlobalKey<FormState> untuk validasi form tambah user
  // // TODO 2: Buat TextEditingController untuk email, password, userId (A-00x), dan nama user
  final key = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String selectedRole = 'user';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Admin Page"),
        actions: <Widget>[
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      // // TODO 3: Ganti Center dengan SingleChildScrollView agar halaman bisa di-scroll
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Super Admin Dashboard",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // // TODO 4: Buat Form untuk input user baru
              // // Di dalam Form, tambahkan:
              // // a. TextFormField untuk User ID (misal: ADMIN-02 atau USER-01)
              // // b. TextFormField untuk Email User
              // // c. TextFormField untuk Password User
              // // d. DropdownButtonFormField untuk memilih Role ('admin' atau 'user')
              Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: userIdController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "User Id",
                        hintText: "Masukan User Id",
                        prefixIcon: Icon(Icons.badge),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "User Id Wajib Diisi";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Masukan Username",
                        prefixIcon: Icon(Icons.person_2),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username Wajib Diisi";
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
                        hintText: "Masukan Email",
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
                        hintText: "Masuka Password",
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
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Pilih Role",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.settings_accessibility),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'user',
                          child: Text("User Biasa"),
                        ),
                        DropdownMenuItem(
                          value: 'admin',
                          child: Text("Admin Sekolah"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsetsGeometry.all(15),
                      child: MaterialButton(
                        onPressed: isLoading ? null : () => createUser(),
                        minWidth: double.infinity,
                        color: Colors.black,
                        textColor: Colors.white,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Daftarkan Akun"),
                      ),
                    ),
                  ],
                ),
              ),
              // // TODO 5: Buat MaterialButton atau ElevatedButton untuk memicu fungsi registerUser()
              Divider(height: 40, thickness: 2),

              Text(
                "Daftar Akun Terdaftar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // // TODO 6: Gunakan Expanded dan StreamBuilder/ListView untuk menampilkan daftar user
              // // Untuk sementara (UI saja), kamu bisa gunakan ListView.builder dengan data dummy
              // // Tampilkan informasi: User ID, Email, dan Role dalam bentuk ListTile
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text("Contoh User"),
                    subtitle: Text("user@sekolah.com"),
                    trailing: Text("Role: User"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // // TODO 7: (Opsional) Tambahkan FloatingActionButton jika ingin form input dipisah ke Dialog/Halaman baru
    );
  }

  // // TODO 8: Buat kerangka fungsi Future<void> createUser() async { ... }
  // // Fungsi ini nanti akan berisi logika Firebase Auth & Firestore
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userIdController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> createUser() async {}
}
