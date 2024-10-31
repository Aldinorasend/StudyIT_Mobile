import 'package:flutter/material.dart';

class Coursesubmit extends StatefulWidget {
  const Coursesubmit({super.key});

  @override
  State<Coursesubmit> createState() => _CoursesubmitState();
}

class _CoursesubmitState extends State<Coursesubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          "Task 1: Introduction to UI/UX",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF113F67),
      ),
      body: Column(
        children: [
          //const SizedBox(height: 5.0),
          Container(
            height: 80, 
            width: double.infinity, 
            //margin: const EdgeInsets.only(top: 8), 
            padding: const EdgeInsets.all(16.0), 
            decoration: BoxDecoration(
              color: Colors.white, 
              // borderRadius: BorderRadius.circular(12.0), 
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), 
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0), 
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Description: ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "Understand the basic concepts of UI and UX and their differences.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), 
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
              )
            ]),
            child: const Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task Points:",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8), // Spacing after "Task Points:"
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          "Explain the meaning of UI (User Interface) and UX (User Experience).",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2. ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          "Identify the main differences between UI and UX.",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3. ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          "Provide examples of products or services with good UI design and poor UX, and vice versa.",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
          const SizedBox(height: 110),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman courseSubmit
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Coursesubmit(),
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
                  'Add Submission',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
        ],
      ),
    );
  }
}
