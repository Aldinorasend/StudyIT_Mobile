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

class AppColors {
  static const Color primaryColor = Color(0xFF113F67);
  static const Color secondaryColor = Color(0xFF276AA4);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFD9D9D9);
}

class HomePage extends StatefulWidget {
  final String userId;

  // Tambahkan userId sebagai parameter
  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To handle the current index of the navbar
  late final List<Widget> _pages;
  List<Course> courses = [];
  bool isLoading = true;
  String username = '';
  // var userId;
  @override
  void initState() {
    super.initState();
    _pages = [
      HomePageBody(
        userId: widget.userId,
        courses: [],
        isLoading: true,
        username: username,
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
          username = data['username']; // Simpan username
        });
        if (data['User_Type'] == 'Subscriber') {
          final url = Uri.parse('http://192.168.100.16:3000/api/coursesUser');
          await fetchCourse(url);
        } else if (data['User_Type'] == 'Free') {
          final url = Uri.parse('http://192.168.100.16:3000/api/freeCourses');
          await fetchCourse(url);
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
          if (page is HomePageBody) {
            return HomePageBody(
              courses: courses,
              isLoading: isLoading,
              userId: widget.userId,
              username: username,
            );
          }
          return page;
        }).toList(),
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  final List<Course> courses;
  final bool isLoading;
  final String username;
  const HomePageBody({
    Key? key,
    required this.courses,
    required this.isLoading,
    required this.userId,
    required this.username,
  }) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.5,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                      ),
                      items: [
                        Image.network(
                          "https://images.unsplash.com/photo-1511376777868-611b54f68947?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          "https://images.unsplash.com/photo-1542831371-29b0f74f9713?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          "https://images.unsplash.com/photo-1607799279861-4dd421887fb3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor.withOpacity(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 120,
                        right: 30,
                        left: 30,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          const Text(
                            "From Beginner to Pro: Your IT Career Starts Here",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Expand your Skills and hone your Abilities with our Bootcamps",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: 130,
                            height: 30,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentPage(userId: userId),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  side: BorderSide(
                                    color: AppColors.textColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Upgrade Your Package",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      color: AppColors.primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Welcome, $username",
                            style: TextStyle(
                              fontSize: 17,
                              color: AppColors.textColor,
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Warning"),
                                        content: const Text("Search Feature"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Close"),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const CircleAvatar(
                                  backgroundColor: AppColors.secondaryColor,
                                  child: Icon(
                                    Icons.search,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: const CircleAvatar(
                                  backgroundColor: AppColors.secondaryColor,
                                  child: Icon(
                                    Icons.account_circle,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: screenWidth,
                      child: Center(
                        child: Wrap(
                          spacing: 8, // Jarak horizontal antar elemen
                          runSpacing: 8, // Jarak vertikal antar elemen
                          children: courses.map((course) {
                            return GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseScreen(
                                          userId: userId,
                                          courseId: course.id.toString())),
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.4, // Lebar setiap kartu
                                height: screenHeight * 0.23,
                                decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.7,
                                      height: screenHeight * 0.11,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'lib/backend-uploads/${course.image}'),
                                          fit: BoxFit.fill,
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
                                        course.courseName +
                                            " - " +
                                            course.level[0].toUpperCase() +
                                            course.level.substring(1) +
                                            " Class",
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
                                        "End Date : " + course.description,
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
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
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

  Course({
    required this.id,
    required this.image,
    required this.level,
    required this.courseName,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      image: json['image'],
      level: json['level'],
      courseName: json['course_name'],
      description: json['description'],
    );
  }
}
