import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/qr_generator_screen.dart';
import 'screens/qr_scanner_screen.dart';
import 'screens/attendance_records_screen.dart';
import 'screens/profile_screen.dart'; // New Profile Screen

void main() {
  runApp(AttendEaseApp());
}

class AttendEaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AttendEase',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    HomeScreen(),
    QRGeneratorScreen(),
    QRScannerScreen(),
    AttendanceRecordsScreen(),
    ProfileScreen(), // Added Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Generate QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan QR',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Records'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ), // New Profile Tab
        ],
      ),
    );
  }
}
