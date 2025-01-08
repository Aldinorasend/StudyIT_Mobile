import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:studyit/screen/HomePage.dart';

class Coursesubmit extends StatefulWidget {
  final String userId;
  final String courseId;

  const Coursesubmit({Key? key, required this.userId, required this.courseId})
      : super(key: key);

  @override
  State<Coursesubmit> createState() => _CoursesubmitState();
}

class _CoursesubmitState extends State<Coursesubmit> {
  PlatformFile? pickedFile; // Store selected file details
  Map<String, dynamic>? modulData; // Untuk menyimpan data modul
  bool isLoading = true;
  final String taskUploadUrl = 'http://192.168.100.82:3000/api/tasks/'; // API endpoint

  @override
  void initState() {
    super.initState();
    fetchTaskData();
  }

  Future<void> fetchTaskData() async {
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
        throw Exception('Failed to load task data');
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

  Future<void> submitTask() async {
  if (pickedFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a file to upload.')),
    );
    return;
  }

  // Check if the file type is valid
  final allowedExtensions = ['jpg', 'jpeg', 'png'];
  final fileExtension = pickedFile!.extension?.toLowerCase();
  if (fileExtension == null || !allowedExtensions.contains(fileExtension)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid file type. Only JPG, JPEG, and PNG are allowed.')),
    );
    return;
  }

  final uri = Uri.parse(taskUploadUrl);
  final request = http.MultipartRequest('POST', uri);

  request.files.add(await http.MultipartFile.fromPath(
    'FileTask',
    pickedFile!.path!,
    contentType: MediaType('image', fileExtension), // Set MIME type dynamically
  ));
  request.fields['ModulID'] = widget.courseId;
  request.fields['UserID'] = widget.userId;

  // Add headers if required by the server
  request.headers.addAll({
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
  });

  try {
    print('Sending request to $taskUploadUrl');
    print('Fields: ${request.fields}');
    print('Files: ${request.files.map((file) => file.filename).toList()}');

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print('Response status: ${response.statusCode}');
    print('Response body: $responseBody');

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task submitted successfully!')),
      );
      setState(() {
        pickedFile = null; // Reset the picked file after successful submission
      });

      // Navigate to HomePage with userId
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userId: widget.userId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting: ${response.reasonPhrase}\n$responseBody')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Warning, your changes will not be saved"),
                duration: Duration(seconds: 3),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
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
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Description: ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: modulData?['Description'] ??
                        'Understand the basic concepts of UI and UX and their differences.',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Task Points:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  modulData?['Task'] ?? 'No tasks available.',
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selected File:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (pickedFile != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => OpenFile.open(pickedFile!.path),
                            child: Text(
                              pickedFile!.name,
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                              "Size: ${(pickedFile!.size / 1024).toStringAsFixed(2)} KB"),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                  );
                  if (result != null) {
                    setState(() {
                      pickedFile = result.files.first;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: const Color(0xFF113F67),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add Submission'),
              ),
              ElevatedButton(
                onPressed: pickedFile != null ? submitTask : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: pickedFile != null
                      ? const Color(0xFF113F67)
                      : const Color.fromARGB(255, 159, 164, 168),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
