import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Untuk menyimpan status login
import 'package:studyit/screen/HomePage.dart';
import 'package:studyit/screen/OtpPage.dart';
import 'package:studyit/screen/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool keepSignedIn = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSignedIn = prefs.getBool('keepSignedIn') ?? false;

    if (isSignedIn) {
      // Jika pengguna sudah memilih "Keep me signed in", langsung ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _login(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == "user@example.com" && password == "password123") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (keepSignedIn) {
        // Simpan preferensi pengguna untuk tetap masuk
        await prefs.setBool('keepSignedIn', true);
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF113F67),
            title: const Text(
              "Login Berhasil",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF113F67),
            title: const Text(
              "Login Gagal",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        color: const Color(0xFF113F67),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 65),

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

                // Email Label and TextFormField
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
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

                // Password Label and TextFormField
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
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

                // Keep Me Signed In Checkbox
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: keepSignedIn,
                          onChanged: (bool? value) {
                            setState(() {
                              keepSignedIn = value ?? false;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: const Color(0xFF113F67),
                          side: BorderSide(color: Colors.white),
                        ),
                        const Text(
                          "Keep me signed in",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Forgot Password Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OtpPage()),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    _login(context);
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

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have an Account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Create Here',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF113F67),
    );
  }
}
