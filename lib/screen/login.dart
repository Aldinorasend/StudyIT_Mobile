import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Color(0xFF113F67),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Title
              Text(
                'Login to StudyIT',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Inter",
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),

              // Email Label and TextField
              Text(
                "Email",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 5),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 20),

              // Password Label and TextField
              Text(
                "Password",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 5),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 20),

              // Forgot Password Button Aligned Right
              Transform.translate(
                offset: Offset(-125, 0),
                child: TextButton(
                  onPressed: () {
                    // Add Forgot Password action
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  _login(context); // Panggil fungsi _login saat tombol ditekan
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  foregroundColor: Color(0xFF113F67),
                  backgroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF113F67),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Divider OR
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('OR', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(child: Divider(color: Colors.white)),
                ],
              ),

              SizedBox(height: 20),

              // Continue with Google
              ElevatedButton.icon(
                onPressed: () {
                  // Add Google login action
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    iconColor: Color(0xFF113F67),
                    backgroundColor: Color(0xFF113F67),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white))),
                icon: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                  height: 24.0,
                  width: 24.0,
                ),
                label: Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 20),

              // Continue with Apple
              ElevatedButton.icon(
                onPressed: () {
                  // Add Apple login action
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    iconColor: Color(0xFF113F67),
                    backgroundColor: Color(0xFF113F67),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white))),
                icon: Icon(Icons.apple, color: Colors.white),
                label: Text(
                  'Continue with Apple',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF113F67),
    );
  }
}
