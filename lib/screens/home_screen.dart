import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AttendEase")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/generate_qr'),
              child: Text("Generate QR Code"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/scan_qr'),
              child: Text("Scan QR Code"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  () => Navigator.pushNamed(context, '/attendance_records'),
              child: Text("View Attendance Records"),
            ),
          ],
        ),
      ),
    );
  }
}
