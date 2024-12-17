import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _passwordError;
  bool _obscurePassword = true;

  // Password validation function
  String? _validatePassword(String value) {
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,16}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be 8-16 characters, include one uppercase letter and one special character.';
    }
    return null;
  }

  void _onSubmit() {
    final password = _passwordController.text;
    final error = _validatePassword(password);
    setState(() {
      _passwordError = error;
    });

    if (error == null) {
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _passwordError = 'Passwords do not match.';
        });
        return;
      }
      // Perform registration action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Get Your Free Account',
                    style: TextStyle(
                        fontSize: 32, fontFamily: "Inter", color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  // Email Label and TextFormField
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _emailController,
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _passwordController,
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
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _confirmPasswordController,
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
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _onSubmit,
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
                      'Continue With Email',
                      style: TextStyle(fontSize: 16, color: Color(0xFF113F67)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Have an Account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {},
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
      backgroundColor: const Color(0xFF113F67),
    );
  }
}
