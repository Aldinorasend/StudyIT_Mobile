import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyit/screen/HomePage.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF113F67);
  static const Color secondaryColor = Color(0xFF276AA4);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFD9D9D9);
}

class BillingPage extends StatefulWidget {
  final String paymentMethod;
  
  const BillingPage({
    Key? key,
    required this.paymentMethod, required String email, required String vaNumber, required int amount,
  }) : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;
  String? virtualAccount;
  bool _isPaymentComplete = false;

  @override
  void initState() {
    super.initState();
    _generateVirtualAccount();
  }

  void _generateVirtualAccount() {
    // Generate Virtual Account number (in production this would come from your backend)
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final vaNumber = timestamp.length > 14 ? timestamp.substring(8, 14) : timestamp;
    setState(() {
      virtualAccount = '8277$vaNumber';
    });
  }

  Future<void> _simulatePaymentCheck() async {
    if (_isLoading) return;

    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan email Anda'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    // Simulate payment verification delay
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
      _isPaymentComplete = true;
    });

    // Show success dialog
    if (!mounted) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          'Pembayaran Berhasil',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/images/payment.png',
              height: 100,
              width: 100,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.check_circle, size: 100, color: Colors.green),
            ),
            const SizedBox(height: 16),
            const Text(
              'Terima kasih! Pembayaran Anda telah berhasil.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Email konfirmasi telah dikirim ke:\n${emailController.text}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
            child: const Text(
              'OK',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Pembayaran BCA',
          style: TextStyle(color: AppColors.textColor),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Amount Card
            Card(
              color: AppColors.secondaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16,
                          ),
                        ),
                        Image.asset(
                          'lib/images/bca.png',
                          height: 30,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rp 50.000',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Virtual Account Section
            const Text(
              'Virtual Account BCA',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.buttonColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      virtualAccount ?? 'Generating...',
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: AppColors.textColor),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: virtualAccount ?? ''));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nomor VA berhasil disalin'),
                          backgroundColor: AppColors.secondaryColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Email Input
            const Text(
              'Email',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              style: const TextStyle(color: AppColors.textColor),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Masukkan email Anda',
                hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5)),
                filled: true,
                fillColor: AppColors.secondaryColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.textColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email, color: AppColors.textColor),
              ),
            ),
            const SizedBox(height: 32),

            // Check Payment Button
            ElevatedButton(
              onPressed: _isLoading ? null : _simulatePaymentCheck,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                foregroundColor: AppColors.primaryColor,
                disabledBackgroundColor: AppColors.buttonColor.withOpacity(0.6),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                      ),
                    )
                  : const Text(
                      'Cek Status Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 24),

            // Payment Instructions
            Card(
              color: AppColors.secondaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.textColor),
                        SizedBox(width: 8),
                        Text(
                          'Cara Pembayaran:',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Buka aplikasi BCA Mobile\n'
                      '2. Pilih m-BCA\n'
                      '3. Pilih m-Transfer\n'
                      '4. Pilih BCA Virtual Account\n'
                      '5. Masukkan nomor Virtual Account\n'
                      '6. Konfirmasi detail pembayaran\n'
                      '7. Masukkan PIN m-BCA\n'
                      '8. Pembayaran selesai',
                      style: TextStyle(
                        color: AppColors.textColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.access_time, color: AppColors.textColor, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Selesaikan pembayaran dalam 24 jam',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}