import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    // Contoh validasi sederhana: email dan password harus sesuai
    if (email == "user@example.com" && password == "password123") {
      _showDialog(context, "Login berhasil");
    } else {
      _showDialog(context, "Login gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: const Color(0xFF113F67),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Login to StudyIT',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Inter",
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              // Email Label and TextField
              const Text(
                "Email",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 20),

              // Password Label and TextField
              const Text(
                "Password",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 20),

              // Forgot Password Button Aligned Right
              Transform.translate(
                offset: const Offset(-125, 0),
                child: TextButton(
                  onPressed: () {
                    // Add Forgot Password action
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  _login(context); // Panggil fungsi _login saat tombol ditekan
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  foregroundColor: const Color(0xFF113F67),
                  backgroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF113F67),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF113F67),
    );
  }
}
