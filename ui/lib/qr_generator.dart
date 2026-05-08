import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'api_client.dart';

class QRPage extends StatelessWidget {
  final ApiClient apiClient;

  const QRPage({super.key, required this.apiClient});

  Widget _buildQRCard(String data) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 200,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(height: 40),
        Text(
          "Your QR Code",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Scan this at the reader to gain points",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final qrData = "${apiClient.studentId}:${apiClient.authToken}";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("QR Code"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 30),

              _buildQRCard(qrData),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.info_outline, size: 18, color: Colors.black54),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "Make sure your brightness is high for easy scanning",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),

              const Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}