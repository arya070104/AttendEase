import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isProcessing = false; // Prevent multiple rapid scans

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (isProcessing || scanData.code == null) return;

      setState(() => isProcessing = true);

      await _markAttendance(scanData.code!);

      await Future.delayed(Duration(seconds: 2));
      setState(() => isProcessing = false);
    });
  }

  Future<void> _markAttendance(String rollNumber) async {
    try {
      await FirebaseFirestore.instance.collection('attendance').add({
        'rollNumber': rollNumber,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'Present',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Attendance Marked for $rollNumber")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code")),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            child: Center(child: Text("📷 Scan a QR Code")),
          ),
        ],
      ),
    );
  }
}
