import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studyit/screen/billing_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class AppColors {
  static const Color primaryColor = Color(0xFF113F67);
  static const Color secondaryColor = Color(0xFF276AA4);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFD9D9D9);
}

class MidtransConfig {
  // Replace with your Midtrans keys
  static const String clientKey = 'SB-Mid-client-sxzhxYHAInrZ-2Ms';
  static const String serverKey = 'SB-Mid-server-uVuUBWHSd0rYB_-t2i1fdXF1';
  
  // Sandbox URL for development
  static const String baseUrl = 'https://api.sandbox.midtrans.com';
  // Production URL
  // static const String baseUrl = 'https://api.midtrans.com';
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = false;

  Future<Map<String, dynamic>> createTransaction({
    required String paymentType,
    required int amount,
    required String orderId,
  }) async {
    try {
      print('Creating transaction for $paymentType with amount $amount');
      final response = await http.post(
        Uri.parse('${MidtransConfig.baseUrl}/v2/charge'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Basic ${base64Encode(utf8.encode(MidtransConfig.serverKey + ':'))}',
        },
        body: jsonEncode({
          'payment_type': paymentType,
          'transaction_details': {
            'order_id': orderId,
            'gross_amount': amount,
          },
          'customer_details': {
            'first_name': 'John',
            'last_name': 'Doe',
            'email': 'john@example.com',
            'phone': '08111222333',
          },
          if (paymentType == 'bank_transfer') 'bank_transfer': {'bank': 'bca'},
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Decoded response: $responseData');
        return responseData;
      } else {
        throw Exception('Failed to create transaction: ${response.body}');
      }
    } catch (e) {
      print('Error in createTransaction: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> checkTransactionStatus(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('${MidtransConfig.baseUrl}/v2/$orderId/status'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Basic ${base64Encode(utf8.encode(MidtransConfig.serverKey + ':'))}',
        },
      );

      print('Status check response: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to check transaction status');
      }
    } catch (e) {
      print('Error checking status: $e');
      throw Exception('Error checking status: $e');
    }
  }

  Future<void> _handlePayment(String paymentMethod) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final orderId = 'ORDER-${DateTime.now().millisecondsSinceEpoch}';
      final amount = 50000; // Adjust the amount as needed
      
      final result = await createTransaction(
        paymentType: _getPaymentType(paymentMethod),
        amount: amount,
        orderId: orderId,
      );

      Navigator.pop(context); // Remove loading indicator

      print('Payment result: $result'); // Debug print

      switch (paymentMethod.toLowerCase()) {
        case 'qris':
          if (result.containsKey('qr_string')) {
            final qrString = result['qr_string'];
            _showQRCode(qrString); // Menggunakan qr_string untuk generate QR code
            _startPaymentStatusCheck(orderId);
          } else {
            throw Exception('QR code data not found in response');
          }
          break;
          
        case 'gopay':
          if (result.containsKey('actions')) {
            final deeplink = result['actions'].firstWhere(
              (action) => action['name'] == 'deeplink-redirect',
              orElse: () => {'url': null},
            )['url'];
            
            if (deeplink != null) {
              await _handleGopayDeeplink(deeplink);
            }
          }
          break;
          
        case 'dana':
          if (result.containsKey('actions')) {
            final deeplink = result['actions'].firstWhere(
              (action) => action['name'] == 'deeplink-redirect',
              orElse: () => {'url': null},
            )['url'];
            
            if (deeplink != null) {
              await _handleDanaDeeplink(deeplink);
            }
          }
          break;

        case 'ovo':
          if (result.containsKey('actions')) {
            final deeplink = result['actions'].firstWhere(
              (action) => action['name'] == 'deeplink-redirect',
              orElse: () => {'url': null},
            )['url'];
            
            if (deeplink != null) {
              await _handleOVODeeplink(deeplink);
            }
          }
          break;

        case 'bca':
          if (result.containsKey('va_numbers')) {
            final vaNumber = result['va_numbers'].first['va_number'];
            final email = result['customer_details']['email'];
            print('VA Number: $vaNumber, Email: $email'); // Debug print
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BillingPage(
                  email: email,
                  vaNumber: vaNumber,
                  paymentMethod: paymentMethod,
                  amount: amount,
                ),
              ),
            );
          } else {
            print('VA numbers not found in response'); // Debug print
          }
          break;
          
        default:
          _showPaymentInstructions(result);
          break;
      }

    } catch (e) {
      if (_isProcessing) {
        Navigator.pop(context); // Remove loading indicator if still showing
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Error: $e')),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  String _getPaymentType(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'qris':
        return 'qris';
      case 'gopay':
        return 'gopay';
      case 'dana':
        return 'dana';
      case 'ovo':
        return 'ovo';
      case 'bca':
        return 'bank_transfer';
      default:
        return 'bank_transfer';
    }
  }

  void _showQRCode(String qrString) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Scan QR Code'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: QrImageView(
                  data: qrString,
                  version: QrVersions.auto,
                  size: 250.0,
                  backgroundColor: Colors.white,
                  errorStateBuilder: (context, error) => Center(
                    child: Text(
                      'Error generating QR code: $error',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Scan QR code menggunakan aplikasi pembayaran Anda',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Total Pembayaran: Rp 50.000',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleGopayDeeplink(String deeplinkUrl) async {
    await _launchURL(deeplinkUrl, 'Gopay');
  }

  Future<void> _handleDanaDeeplink(String deeplinkUrl) async {
    await _launchURL(deeplinkUrl, 'Dana');
  }

  Future<void> _handleOVODeeplink(String deeplinkUrl) async {
    await _launchURL(deeplinkUrl, 'OVO');
  }

  Future<void> _handleCardPayment(String redirectUrl) async {
    await _launchURL(redirectUrl, 'payment');
  }

  Future<void> _launchURL(String url, String appName) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $appName')),
      );
    }
  }

  void _showPaymentInstructions(Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Instructions'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (result.containsKey('actions')) ...[
                for (var action in result['actions'])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('${action['name']}: ${action['url']}'),
                  ),
              ],
              if (result.containsKey('payment_code'))
                Text('Payment Code: ${result['payment_code']}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _startPaymentStatusCheck(String orderId) async {
    bool isPaid = false;
    int attempts = 0;
    const maxAttempts = 20; // Check for 5 minutes (15 seconds interval)

    while (!isPaid && attempts < maxAttempts) {
      try {
        final status = await checkTransactionStatus(orderId);
        
        if (status['transaction_status'] == 'settlement' ||
            status['transaction_status'] == 'capture') {
          isPaid = true;
          if (!mounted) return;
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pembayaran Berhasil!')),
          );
          Navigator.pop(context, true);
          return;
        }
        
        attempts++;
        await Future.delayed(const Duration(seconds: 15));
      } catch (e) {
        print('Error checking payment status: $e');
      }
    }

    if (!isPaid && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Waktu pembayaran habis. Silakan coba lagi.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          'Metode Pembayaran',
          style: TextStyle(color: AppColors.textColor, fontSize: 20),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          _buildPaymentOption('Qris', 'lib/images/Qris.png'),
          _buildPaymentOption('BCA', 'lib/images/bca.png'),
          _buildPaymentOption('Dana', 'lib/images/Dana.png'),
          _buildPaymentOption('Gopay', 'lib/images/Gopay.png'),
          _buildPaymentOption('OVO', 'lib/images/OVO.png'),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, String imagePath) {
    return GestureDetector(
      onTap: () => _handlePayment(title),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}