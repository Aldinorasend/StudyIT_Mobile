import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyit/screen/notification.dart';
import 'package:studyit/package/NavbarBottom.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF113F67);
  static const Color secondaryColor = Color(0xFF276AA4);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFD9D9D9);
}

class BillingPage extends StatefulWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  int _currentIndex = 0; // To handle the current index of the navbar

  final List<Widget> _pages = [
    BillingAddressScreen(), // Page content for the home
    const Center(child: Text("Search Page")), // Dummy page for search
    const Center(child: Text("Profile Page")), // Dummy page for profile
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

class BillingAddressScreen extends StatelessWidget {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  BillingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.buttonColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF033D68)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Billing Address',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.normal,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 35),
            _buildLabelAndTextField(
              label: 'Country',
              controller: countryController,
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 25),
            _buildLabelAndTextField(
              label: 'City',
              controller: cityController,
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 25),
            _buildLabelAndTextField(
              label: 'Street',
              controller: streetController,
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 25),
            _buildLabelAndTextField(
              label: 'Zip Code',
              controller: zipCodeController,
              inputType: TextInputType.number,
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 45),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  NotificationService.showNotification(
                  context,
                  title: 'Payment',
                  message: 'Payment telah berhasil dibayarkan',
                  imagePath: 'lib/images/payment.png', 
                  duration: Duration(seconds: 5),
                );
              },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
                      ],
                    ),
                  ),
                );
              }

  Widget _buildLabelAndTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType inputType,
    List<TextInputFormatter>? inputFormatter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textColor, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: inputType,
          inputFormatters: inputFormatter,
          style: const TextStyle(color: AppColors.textColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF033D68),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.textColor, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.textColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}