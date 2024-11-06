import 'videoWidget.dart';
import 'package:flutter/material.dart';
import 'courseSubmit.dart';

class Videopage extends StatefulWidget {
  const Videopage({super.key});

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          "Video Module",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF113F67),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SamplePlayer(),

            Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 3.5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        'What is UI & UX Design?',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 420),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman courseSubmit
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const Coursesubmit(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: const Color(0xFF113F67),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Task',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}