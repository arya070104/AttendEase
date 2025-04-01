import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code")),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            print("Scanned: ${barcode.rawValue}");
          }
        },
      ),
    );
  }
}
