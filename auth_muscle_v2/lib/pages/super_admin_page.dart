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

  String? adminSchoolId;
  String selectedRole = 'user';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getAdminSchoolId();
  }

  Future<void> _getAdminSchoolId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (mounted) {
        setState(() {
          adminSchoolId = doc['schoolId'];
        });
      }
    }
  }

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
              adminSchoolId == null
                  ? const CircularProgressIndicator()
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('schoolId', isEqualTo: adminSchoolId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("Belum ada data user di sekolah ini"),
                          );
                        }
                        var docs = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var userData =
                                docs[index].data() as Map<String, dynamic>;
                            return ListTile(
                              title: Text(userData['username'] ?? '_'),
                              subtitle: Text(userData['email'] ?? '_'),
                              trailing: Text(userData['role'] ?? 'user'),
                            );
                          },
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

    if (!key.currentState!.validate()) return;

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
      final adminUser = FirebaseAuth.instance.currentUser;
      final emailAdmin = adminUser?.email;
      final adminDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(adminUser!.uid)
          .get();
      final String schoolId = adminDoc['schoolId'];
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .where('schoolId', isEqualTo: schoolId)
          .get();

      if (querySnapshot.docs.isNotEmpty)
        throw "User ID $userId sudah terdaftar di sekolah ini";

      UserCredential newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.user!.uid)
          .set({
            'email': emailController.text.trim(),
            'username': usernameController.text.trim(),
            'userId': userIdController.text.trim(),
            'role': selectedRole,
            'schoolId': schoolId,
            'isActive': true,
          });

      _clearForm();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAdmin!,
        password: adminPassword,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Akun Berhasil Dibuat"),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String msg = "Terjadi Kesalahan";
      if (e.code == 'email-already-in-use') {
        msg = 'Email sudah terdaftar';
      } else if (e.code == 'weak-password') {
        msg = 'Password terlalu lemah';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if(mounted) setState(() => isLoading = false);
    }
  }

  void _clearForm() {
    emailController.clear();
    passwordController.clear();
    userIdController.clear();
    usernameController.clear();
  }
}
