import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {
  const registerPage({super.key});

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
            Text(
              'Get Your Free Account',
              style: TextStyle(
                  fontSize: 32, fontFamily: "Inter", color: Colors.white),
            ),
            SizedBox(height: 40),

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

            SizedBox(height: 40),
            // Email Label and TextField
            Text(
              "Email",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(height: 5),
            TextField(
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

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                // Add Login action here
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                foregroundColor: Color(0xFF113F67), // Change text color to blue
                backgroundColor:
                    Colors.white, // Change background color to white
                elevation: 2, // Optional: Add shadow for elevation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  side: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
              child: Text(
                'Continue With Email',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF113F67)), // Keep text color blue
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have an Account?",
                  style: TextStyle(
                    color: Colors.white, // Color for "Already Have an Account?"
                  ),
                ),
                SizedBox(width: 4), // Space between the two texts
                GestureDetector(
                  onTap: () {
                    // Navigate to login page or handle login
                  },
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
              ],
            ),
          ],
        ),
      )),
      backgroundColor: Color(0xFF113F67),
    );
  }
}
