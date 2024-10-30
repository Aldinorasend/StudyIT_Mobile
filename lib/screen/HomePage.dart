import 'package:flutter/material.dart';
import 'package:studyit/package/NavbarBottom.dart';

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
    HomePageBody(), // Page content for the home
    Center(child: Text("Search Page")), // Dummy page for search
    Center(child: Text("Profile Page")), // Dummy page for profile
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/images/background.png"),
                        fit: BoxFit.cover,
                      ),
                      color: AppColors.buttonColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 150, right: 20, left: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            "From Beginner to Pro: Your IT Career Starts Here",
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Expand your Skills and hone your Abilities with our Bootcamps",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 160,
                            height: 40,
                            padding: EdgeInsets.all(3),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Upgrade Your Package",
                                style: TextStyle(
                                    fontSize: 11, fontFamily: 'Inter'),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  // CONTAINER NAVBAR
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
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
                                          title: Text("Warning"),
                                          content: Text("Search Feature"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close"),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.secondaryColor,
                                  child: Icon(
                                    Icons.search,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
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
                  decoration: BoxDecoration(color: AppColors.textColor),
                  margin: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        // Card 1
                        Container(
                          width: 191,
                          height: 153,
                          decoration: BoxDecoration(
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5.0),
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
                          width: 191,
                          height: 153,
                          decoration: BoxDecoration(
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5.0),
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
                        Container(
                          width: 191,
                          height: 153,
                          decoration: BoxDecoration(
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5.0),
                                child: Text(
                                  "UI-UX Beginner Class",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.textColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Card 4
                        Container(
                          width: 191,
                          height: 153,
                          decoration: BoxDecoration(
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5.0),
                                child: Text(
                                  "UI-UX Beginner Class",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.textColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Card 5
                        Container(
                          width: 191,
                          height: 153,
                          decoration: BoxDecoration(
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5.0),
                                child: Text(
                                  "UI-UX Beginner Class",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.textColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Card 6
                        Container(
                          width: 191,
                          height: 153,
                          decoration: BoxDecoration(
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("lib/images/uiux.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              // Title
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5.0),
                                child: Text(
                                  "UI-UX Beginner Class",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.textColor),
                                ),
                              )
                            ],
                          ),
                        )
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
