import 'package:flutter/material.dart';
import 'timetable_screen.dart';
import 'attendance_records_screen.dart';
import 'fees_payment_screen.dart';
import 'student_profile_screen.dart';

class StudentDashboard extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const StudentDashboard({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0; // Default to Timetable screen

  @override
  Widget build(BuildContext context) {
    // List of screens corresponding to each tab
    final List<Widget> _screens = [
      TimetableScreen(),         // Default screen (Timetable)
      FeesPaymentScreen(),       // Fees Payment
      AttendanceRecordsScreen(), // Attendance Records
      ProfileScreen(isDarkMode: widget.isDarkMode, toggleTheme: widget.toggleTheme), // Profile
    ];

    return Scaffold(
      body: _screens[_selectedIndex], // Show the selected screen
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
            icon: Icon(Icons.schedule),
            label: "Timetable",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: "Fees",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Attendance",
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
