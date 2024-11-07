import 'package:flutter/material.dart';

class forgotPassPage extends StatelessWidget {
  const forgotPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Forgot Your Password?',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: "Inter",
                          color: Colors.white),
                    ),
                    const SizedBox(height: 40),

                    // Email Label and TextField
                    const Text(
                      "Enter Your Email Below",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    TextField(
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

                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () {
                        // Add Login action here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        foregroundColor: const Color(
                            0xFF113F67), // Change text color to blue
                        backgroundColor:
                            Colors.white, // Change background color to white
                        elevation: 2, // Optional: Add shadow for elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          side:
                              const BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF113F67)), // Keep text color blue
                      ),
                    ),
                  ]))),
      backgroundColor: const Color(0xFF113F67),
    );
  }
}
