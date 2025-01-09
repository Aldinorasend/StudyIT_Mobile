// ignore: file_names
// Use flutter_asset_manifest.AssetManifest or google_fonts_asset_manifest.AssetManifest

import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:studyit/package/NavbarBottom.dart';
import 'package:studyit/screen/EditProfile.dart';
import 'package:studyit/screen/coursePage.dart';
import 'package:studyit/screen/login.dart';
import 'package:studyit/screen/payment_page.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF113F67);
  static const Color secondaryColor = Color(0xFF276AA4);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFD9D9D9);
}

class Listofcourse extends StatefulWidget {
  final String userId;
  final bool subscriber = false;
  // var courseId;

  // Tambahkan userId sebagai parameter
  const Listofcourse({Key? key, required this.userId}) : super(key: key);

  @override
  _ListOfCourseState createState() => _ListOfCourseState();
}

class _ListOfCourseState extends State<Listofcourse> {
  int _currentIndex = 0; // To handle the current index of the navbar
  late final List<Widget> _pages;
  List<Course> courses = [];
  bool isLoading = true;
  String username = '';
  String userType = '';

  // var userId;
  @override
  void initState() {
    super.initState();
    _pages = [
      ListOfCoursePageBody(
        userId: widget.userId,
        courses: [],
        isLoading: true,
        username: username,
        userType: userType,
      ), // Teruskan userId ke HomePageBody
      // CourseScreen(userId: widget.userId, courseId: widget.courseId,),
      // EditProfileScreen(
      //     userId: widget.userId), // Teruskan userId ke EditProfileScreen
    ];
    fetchAccount();
  }

  Future<void> fetchAccount() async {
    setState(() {
      isLoading = true;
    });
    final urlUser =
        Uri.parse('http://192.168.100.16:3000/api/Accounts/${widget.userId}');
    try {
      final response = await http.get(urlUser);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          username = data['username'];
          userType = data['User_Type']; // Simpan username
        });
        if (data['User_Type'] == 'Subscriber') {
          final url = Uri.parse('http://192.168.100.16:3000/api/coursesUser');
          await fetchCourse(url);
          userType = data['User_Type'];
        } else if (data['User_Type'] == 'Free') {
          final url = Uri.parse('http://192.168.100.16:3000/api/freeCourses');
          await fetchCourse(url);
          userType = data['User_Type'];
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e'); // Log error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> fetchCourse(Uri url) async {
    try {
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // Cek hasil response

      if (response.statusCode == 200) {
        print('Data loaded');
        setState(() {
          final List<dynamic> courseJson = json.decode(response.body);
          courses = courseJson.map((json) => Course.fromJson(json)).toList();

          isLoading = false;
        });
      } else {
        print('Failed to load courses');
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e'); // Log error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.map((page) {
          if (page is ListOfCoursePageBody) {
            return ListOfCoursePageBody(
              courses: courses,
              isLoading: isLoading,
              userId: widget.userId,
              username: username,
              userType: userType,
            );
          }
          return page;
        }).toList(),
      ),
    );
  }
}

class ListOfCoursePageBody extends StatelessWidget {
  final List<Course> courses;
  final bool isLoading;
  final String username;
  final String userType;
  const ListOfCoursePageBody({
    Key? key,
    required this.courses,
    required this.isLoading,
    required this.userId,
    required this.username,
    required this.userType,
  }) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "List of Courses",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text("Sort By"),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Center(child: Text("data")),
                            width: 40,
                            height: 20,
                            decoration:
                                BoxDecoration(color: AppColors.buttonColor),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseScreen(
                                    userId: userId,
                                    courseId: course.id.toString())),
                          );
                        },
                        child: Container(
                          width: screenWidth, // Full width of the screen
                          margin: const EdgeInsets.only(
                              bottom: 10.0), // Margin between items
                          decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.23,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/backend-uploads/${course.image}'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                              ),
                              // Title
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${course.courseName} - ${course.level[0].toUpperCase()}${course.level.substring(1)} Class",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Description
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 3.0, left: 8.0, bottom: 8.0),
                                child: Text(
                                  "End Date : ${DateFormat('dd MMM yyyy').format(course.endDate)}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class Course {
  final int id;
  final String image;
  final String courseName;
  final String level;
  final String description;
  final DateTime endDate; // Ubah tipe dari String ke DateTime

  Course({
    required this.id,
    required this.image,
    required this.level,
    required this.courseName,
    required this.description,
    required this.endDate,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      image: json['image'],
      level: json['level'],
      courseName: json['course_name'],
      description: json['description'],
      endDate:
          DateTime.parse(json['end_date']), // Parsing dari string ke DateTime
    );
  }
}
