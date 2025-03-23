import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorScreen extends StatelessWidget {
  QRGeneratorScreen({Key? key}) : super(key: key);

  final String studentId = "22CSU414"; // Example student ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate QR Code")),
      body: Center(child: QrImageView(data: studentId, size: 200.0)),
    );
  }
}
