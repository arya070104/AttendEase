import 'package:flutter/material.dart';
import 'qr_scanner_screen.dart';
import 'edit_attendance_screen.dart';
import 'teacher_profile_screen.dart';

class TeacherDashboard extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const TeacherDashboard({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      QRScannerScreen(),
      EditAttendanceScreen(),
      TeacherProfileScreen(isDarkMode: widget.isDarkMode, toggleTheme: widget.toggleTheme), // Pass correct values
    ];

    return Scaffold(
      body: screens[_selectedIndex], // Show the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green, // Active tab color
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Scan QR",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "Edit Attendance",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
