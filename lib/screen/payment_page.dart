import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'billing_page.dart';
import 'package:studyit/package/NavbarBottom.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF113F67);
  static const Color secondaryColor = Color(0xFF276AA4);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFD9D9D9);
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedMonth;
  String? selectedYear;
  String? selectedPaymentMethod;

  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    super.dispose();
  }

  void setSelectedPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.buttonColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upgrade Your Package',
              style: TextStyle(color: AppColors.textColor, fontSize: 30),
            ),
            const SizedBox(height: 20),
            _buildPaymentMethodSelector(),
            const SizedBox(height: 30),
            const Text('Name on Card', style: TextStyle(color: AppColors.textColor)),
            const SizedBox(height: 5),
            _buildPaymentField('Name on Card', nameController, false),
            const SizedBox(height: 30),
            const Text('Card Number', style: TextStyle(color: AppColors.textColor)),
            const SizedBox(height: 5),
            _buildPaymentField('Card Number', cardNumberController, true, inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            const SizedBox(height: 30),
            const Text('Card Expiration', style: TextStyle(color: AppColors.textColor)),
            const SizedBox(height: 5),
            _buildExpirationFields(),
            const SizedBox(height: 30),
            _buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
          const SizedBox(width: 54),
          Row(
            children: ['visa', 'mastercard', 'amex'].map((method) {
              return GestureDetector(
                onTap: () => setSelectedPaymentMethod(method),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.50),
                  child: Opacity(
                    opacity: selectedPaymentMethod == method ? 1.0 : 0.5,
                    child: Image.asset(
                      'lib/images/$method.png',
                      height: 35,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentField(String label, TextEditingController controller, bool isNumeric, {List<TextInputFormatter>? inputFormatters}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: AppColors.textColor),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: const TextStyle(color: AppColors.textColor),
    );
  }

  Widget _buildExpirationFields() {
    return Row(
      children: [
        Expanded(
          child: _ExpirationDropdown(
            items: List.generate(12, (index) => (index + 1).toString().padLeft(2, '0')),
            hint: 'Month',
            value: selectedMonth,
            onChanged: (value) => setState(() => selectedMonth = value),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _ExpirationDropdown(
            items: List.generate(10, (index) => (2024 + index).toString()),
            hint: 'Year',
            value: selectedYear,
            onChanged: (value) => setState(() => selectedYear = value),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => BillingAddressScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.secondaryColor, backgroundColor: AppColors.buttonColor,
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
    );
  }
}

class _ExpirationDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final String? value;
  final ValueChanged<String?> onChanged;

  const _ExpirationDropdown({
    required this.items,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.textColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.secondaryColor),
        ),
      ),
      dropdownColor: AppColors.buttonColor,
      value: value,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                // Warna teks dalam dropdown list (saat dibuka)
                child: Text(
                  item, 
                  style: TextStyle(
                    color: value == item ? AppColors.textColor : AppColors.primaryColor
                  ),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      hint: Text(hint, style: const TextStyle(color: AppColors.textColor)),
      // Warna teks saat item sudah dipilih
      style: const TextStyle(color: AppColors.textColor),
      iconEnabledColor: AppColors.textColor,
      iconDisabledColor: AppColors.textColor,
    );
  }
}

