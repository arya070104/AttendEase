import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorScreen extends StatefulWidget {
  @override
  _QRGeneratorScreenState createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  TextEditingController _idController = TextEditingController();
  String _qrData = "22CSU414"; // Default student ID

  @override
  void dispose() {
    _idController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate QR Code")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: "Enter Student ID",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    if (_idController.text.isNotEmpty) {
                      setState(() {
                        _qrData = _idController.text;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            QrImageView(data: _qrData, size: 200.0),
            SizedBox(height: 20),
            Text("QR Code for: $_qrData",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
