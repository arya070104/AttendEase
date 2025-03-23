import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/qr_generator_screen.dart';
import 'screens/qr_scanner_screen.dart';
import 'screens/attendance_records_screen.dart';

void main() {
  runApp(AttendEaseApp());
}

class AttendEaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AttendEase',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/generate_qr': (context) => QRGeneratorScreen(),
        '/scan_qr': (context) => QRScannerScreen(),
        '/attendance_records': (context) => AttendanceRecordsScreen(),
      },
    );
  }
}
