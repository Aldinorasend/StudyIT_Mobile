import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:studyit/screen/videoPage.dart';

class CourseScreen extends StatefulWidget {
  final String userId;
  final String courseId;

  CourseScreen({Key? key, required this.userId, required this.courseId})
      : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool _learnExpanded = false;
  bool _toolsExpanded = false;
  Map<String, dynamic>? modulData; // Untuk menyimpan data modul
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchModulData();
  }

  Future<void> fetchModulData() async {
    final String url =
        'http://192.168.100.82:3000/api/modulsByCourseID/${widget.courseId}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          modulData = jsonDecode(response.body);
          isLoading = false;
          
        });
      } else {
        throw Exception('Failed to load modul data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userId = widget.userId;
    final String courseId = widget.courseId;
    print(modulData);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ColorfulSafeArea(
        color: const Color(0xFF113F67),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          'lib/backend-uploads/${modulData?['Assetto']}', // URL assetto dari backend
                          errorBuilder: (context, error, stackTrace) =>
                              const Placeholder(),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Text(
                            modulData?['Title'] ?? 'Course Title',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                modulData?['Description'] ?? 'No description',
                                style: const TextStyle(fontSize: 14),
                                // textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1),
                        ),
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
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                modulData?[''] ?? 'No tools added by instructor',
                                style: const TextStyle(fontSize: 14),
                                // textAlign: TextAlign.left,
                              ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Videopage(
                          userId: userId,
                          courseId: courseId.toString(),
                        ),
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
                    'Modul',
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
