import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyit/screen/HomePage.dart';
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
  int _currentIndex = 0; // Menyimpan indeks halaman yang aktif

  // Daftar halaman yang ditampilkan sesuai dengan indeks pada bottom navigation
  final List<Widget> _pages = [
    BillingAddressScreen(),
    const Center(child: Text("Search Page")),
    const Center(child: Text("Profile Page")),
  ];

  // Fungsi untuk mengubah halaman aktif berdasarkan tab yang ditekan
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan halaman sesuai indeks
      bottomNavigationBar: CustomNavbar(
        currentIndex: _currentIndex, // Indeks halaman aktif
        onTap: _onTabTapped, // Callback saat tab ditekan
      ),
    );
  }
}
class BillingAddressScreen extends StatefulWidget {
  @override
  _BillingAddressScreenState createState() => _BillingAddressScreenState();
}

class _BillingAddressScreenState extends State<BillingAddressScreen> {
  // Kontroler teks untuk setiap input alamat
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  bool _isFormValid = false; // simpan status validitas form

  @override
  void initState() {
    super.initState();
    // Menambahkan listener untuk memeriksa validitas form saat ada perubahan input
    countryController.addListener(_checkFormValidity);
    cityController.addListener(_checkFormValidity);
    streetController.addListener(_checkFormValidity);
    zipCodeController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid = countryController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          streetController.text.isNotEmpty &&
          zipCodeController.text.isNotEmpty;
    });
  }

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
                onPressed: _isFormValid // Aktif jika form valid
                    ? () {
                        NotificationService.showNotification(
                          context,
                          title: 'Payment',
                          message: 'Payment telah berhasil dibayarkan',
                          imagePath: 'lib/images/payment.png',
                          duration: const Duration(seconds: 5),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    : null,
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

  // Widget helper untuk membangun label dan input teks
  Widget _buildLabelAndTextField({
    required String label, // Label input
    required TextEditingController controller, // Kontroler teks
    required TextInputType inputType, // Tipe input
    List<TextInputFormatter>? inputFormatter, // Formatter input
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
              borderSide:
                  const BorderSide(color: AppColors.textColor, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.textColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
