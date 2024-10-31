// ignore: file_names
// Use flutter_asset_manifest.AssetManifest or google_fonts_asset_manifest.AssetManifest

import 'package:flutter/material.dart';
import 'package:studyit/package/NavbarBottom.dart';
import 'package:studyit/screen/EditProfile.dart';
import 'package:studyit/screen/coursePage.dart';
import 'package:studyit/screen/payment_page.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF113F67);
  static const Color secondaryColor = Color(0xFF276AA4);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFD9D9D9);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To handle the current index of the navbar

  final List<Widget> _pages = [
    const HomePageBody(), // Page content for the home
    const CourseScreen(), // Dummy page for search
    const EditProfile(), // Dummy page for profile
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavbar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Defining width and height as a percentage of screen dimensions
    final double widgetWidth = screenWidth * 1; // 50% of screen width
    // 40% of screen height
    // 40% of screen height
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: <Widget>[
                  // CONTAINER CTA
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/images/background.png"),
                        fit: BoxFit.cover,
                      ),
                      color: AppColors.buttonColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 150, right: 20, left: 20, bottom: 20),
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
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Expand your Skills and hone your Abilities with our Bootcamps",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 160,
                            height: 40,
                            padding: const EdgeInsets.all(3),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              child: const Text(
                                "Upgrade Your Package",
                                style: TextStyle(
                                    fontSize: 11, fontFamily: 'Inter'),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  // CONTAINER NAVBAR
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
                          const Text(
                            "Welcome, Aldino",
                            style: TextStyle(
                                fontSize: 17, color: AppColors.textColor),
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
                                      });
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
                              const CircleAvatar(
                                backgroundColor: AppColors.secondaryColor,
                                child: Icon(
                                  Icons.account_circle,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Card Bootcamp
            Column(
              children: [
                Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(color: AppColors.textColor),
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        // Card 1
                        Container(
                          width: 160,
                          height: 143,
                          decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              Container(
                                width: 191,
                                height: 97.36,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 5.0),
                                child: Text(
                                  "UI-UX Beginner Class",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.textColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Card 2
                        Container(
                          width: 160,
                          height: 143,
                          decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              Container(
                                width: 191,
                                height: 97.36,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 5.0),
                                child: Text(
                                  "UI-UX Beginner Class",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.textColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Card 3
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Maaf, Anda tidak terdaftar dalam paket berlangganan"),
                                duration: Duration(
                                    seconds: 2), // Durasi snackbar muncul
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            height: 143,
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image with overlay and lock icon
                                Stack(
                                  children: [
                                    Container(
                                      width: 191,
                                      height: 97.36,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage("lib/images/uiux.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                        color: AppColors.buttonColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Overlay
                                    Container(
                                      width: 160,
                                      height: 143,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Lock Icon and Text
                                    const Positioned(
                                      top: 55,
                                      left: 75,
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 55,
                                      left: 15,
                                      child: Text(
                                        "Unlock With Subscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 110.0, left: 5.0),
                                      child: Text(
                                        "UI-UX Medium Class",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textColor),
                                      ),
                                    ),
                                  ],
                                ),
                                // Title
                              ],
                            ),
                          ),
                        ),

                        // Card 4
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Maaf, Anda tidak terdaftar dalam paket berlangganan"),
                                duration: Duration(
                                    seconds: 2), // Durasi snackbar muncul
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            height: 143,
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image with overlay and lock icon
                                Stack(
                                  children: [
                                    Container(
                                      width: 191,
                                      height: 97.36,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage("lib/images/uiux.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                        color: AppColors.buttonColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Overlay
                                    Container(
                                      width: 160,
                                      height: 143,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Lock Icon and Text
                                    const Positioned(
                                      top: 55,
                                      left: 75,
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 55,
                                      left: 15,
                                      child: Text(
                                        "Unlock With Subscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 110.0, left: 5.0),
                                      child: Text(
                                        "UI-UX Medium Class",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textColor),
                                      ),
                                    ),
                                  ],
                                ),
                                // Title
                              ],
                            ),
                          ),
                        ),
                        // Card 5
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Maaf, Anda tidak terdaftar dalam paket berlangganan"),
                                duration: Duration(
                                    seconds: 2), // Durasi snackbar muncul
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            height: 143,
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image with overlay and lock icon
                                Stack(
                                  children: [
                                    Container(
                                      width: 191,
                                      height: 97.36,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage("lib/images/uiux.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                        color: AppColors.buttonColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Overlay
                                    Container(
                                      width: 160,
                                      height: 143,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Lock Icon and Text
                                    const Positioned(
                                      top: 55,
                                      left: 75,
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 55,
                                      left: 15,
                                      child: Text(
                                        "Unlock With Subscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 110.0, left: 5.0),
                                      child: Text(
                                        "UI-UX Expert Class",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textColor),
                                      ),
                                    ),
                                  ],
                                ),
                                // Title
                              ],
                            ),
                          ),
                        ),
                        // Card 6
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Maaf, Anda tidak terdaftar dalam paket berlangganan"),
                                duration: Duration(
                                    seconds: 2), // Durasi snackbar muncul
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            height: 143,
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image with overlay and lock icon
                                Stack(
                                  children: [
                                    Container(
                                      width: 191,
                                      height: 97.36,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage("lib/images/uiux.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                        color: AppColors.buttonColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Overlay
                                    Container(
                                      width: 160,
                                      height: 143,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    // Lock Icon and Text
                                    const Positioned(
                                      top: 55,
                                      left: 75,
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 55,
                                      left: 15,
                                      child: Text(
                                        "Unlock With Subscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 110.0, left: 5.0),
                                      child: Text(
                                        "UI-UX Expert Class",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textColor),
                                      ),
                                    ),
                                  ],
                                ),
                                // Title
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
