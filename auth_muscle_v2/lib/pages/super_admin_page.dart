import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class superAdminPage extends StatefulWidget {
  const superAdminPage({super.key});

  @override
  State<superAdminPage> createState() => _superAdminPage();
}

class _superAdminPage extends State<superAdminPage> {
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
              Divider(height: 40, thickness: 2),
              Text(
                "Daftar Akun Terdaftar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userIdController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> createUser() async {
    final String password = passwordController.text.trim();
    final String email = emailController.text.trim();
    final String userId = userIdController.text.trim();
    final String username = usernameController.text.trim();

    if (key.currentState!.validate()) return;

    String? adminPassword = await showDialog<String>(
      context: context,
      builder: (context) {
        final TextEditingController confirmPassController =
            TextEditingController();
        return AlertDialog(
          title: const Text("Konfirmasi Admin"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Masukan password anda untuk melanjutkan"),
              TextField(
                controller: confirmPassController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password Admin"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context, confirmPassController.text),
              child: const Text("Konfirmasi"),
            ),
          ],
        );
      },
    );

    if (adminPassword == null || adminPassword.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      // // TODO 2: Ambil data sekolah Super Admin yang sedang login.
      // // Kamu butuh 'schoolId' dari admin yang sekarang agar user baru otomatis masuk ke sekolah yang sama.
      // final adminUser = FirebaseAuth.instance.currentUser;
      // final adminDoc = await FirebaseFirestore.instance.collection('users').doc(adminUser!.uid).get();
      // final String schoolId = adminDoc['schoolId'];
      final adminUser = FirebaseAuth.instance.currentUser;
      final adminDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(adminUser!.uid)
          .get();
      final String schoolId = adminDoc['schoolId'];

      // // TODO 3: Cek apakah User ID sudah dipakai di sekolah ini.
      // // Lakukan query ke koleksi 'users' dengan filter 'userId' dan 'schoolId'.
      // // Jika ada, lempar error: "User ID sudah terdaftar di sekolah ini".
      await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .where('schoolId', isEqualTo: schoolId)
          .get();

      // // --- BAGIAN KRUSIAL (Taktik Pembuatan Akun) ---

      // // TODO 4: Simpan kredensial Super Admin yang sedang login sementara.
      // // Kita butuh email & password admin ini untuk login kembali nanti.
      // // Karena Firebase akan otomatis me-login-kan user yang baru dibuat.

      String emailAdmin = FirebaseAuth.instance.currentUser?.email ?? "";

      // // TODO 5: Buat akun di Firebase Auth.
      // // UserCredential newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(...);

      // // TODO 6: Simpan data profil lengkap ke Firestore.
      // // Masukkan ke koleksi 'users' dengan doc ID menggunakan newUser.user!.uid.
      // // Data: email, username, userId, role (selectedRole), schoolId, isActive: true.

      // // TODO 7: Login Kembali sebagai Super Admin.
      // // Setelah akun baru dibuat, Firebase me-login-kan si user baru.
      // // Kita harus paksa login kembali menggunakan kredensial admin (dari TODO 4).
      // // await FirebaseAuth.instance.signInWithEmailAndPassword(...);

      // // TODO 8: Berikan Feedback Sukses.
      // // Tampilkan SnackBar "Akun Berhasil Dibuat", bersihkan semua Controller (clear()).
    } on FirebaseAuthException catch (e) {
      // // TODO 9: Handle error spesifik Firebase (misal: email-already-in-use).
    } catch (e) {
      // // TODO 10: Handle error umum.
    } finally {
      // // TODO 11: Set isLoading = false dan panggil setState.
    }
  }
}
