import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:studyit/screen/videoPage.dart';

class CourseScreen extends StatefulWidget {
  final String userId;
  final String courseId;

  const CourseScreen({
    Key? key,
    required this.userId,
    required this.courseId,
  }) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool _learnExpanded = false;
  bool _toolsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ColorfulSafeArea(
        color: const Color(0xFF113F67),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                      'lib/images/glenn-carstens-peters-P1qyEf1g0HU-unsplash.jpg'),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(
                            context); // Go back to the previous screen
                      },
                    ),
                  ),
                  const Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'UI-UX Intermediate\nClass',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        '25-26 August 2024',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                    top: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: ExpansionTile(
                  title: const Text('What you’ll learn',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  initiallyExpanded: _learnExpanded,
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _learnExpanded = expanded;
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '1. The principles of user-centered design.\n2. How to conduct user research and usability testing.\n3. Creating effective user personas and journey maps.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                ),
                child: ExpansionTile(
                  title: const Text('Tools',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  initiallyExpanded: _toolsExpanded,
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _toolsExpanded = expanded;
                    });
                  },
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Here are some tools you can learn in the UI-UX Beginner Class.',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'lib/images/85f69649-5387-44c2-ba45-81ae13812e36-cover.png',
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'lib/images/adobe1.jpg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 310),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman Videopage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Videopage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: const Color(0xFF113F67),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Enroll Course',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
