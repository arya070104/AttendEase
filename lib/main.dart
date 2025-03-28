import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/qr_generator_screen.dart';
import 'screens/qr_scanner_screen.dart';
import 'screens/attendance_records_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(AttendEaseApp());
}

class AttendEaseApp extends StatefulWidget {
  @override
  _AttendEaseAppState createState() => _AttendEaseAppState();
}

class _AttendEaseAppState extends State<AttendEaseApp> {
  bool _isDarkMode = false;

  void toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AttendEase',
      theme: _isDarkMode ? _darkTheme() : _lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(), // Initial route set to WelcomeScreen
        '/login': (context) => LoginScreen(),
        '/home':
            (context) =>
                MainScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
      },
    );
  }
}

// WhatsApp Light Theme
ThemeData _lightTheme() {
  return ThemeData(
    primaryColor: Color(0xFF075E54), // WhatsApp Green
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF075E54),
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF075E54),
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
  );
}

// WhatsApp Dark Theme
ThemeData _darkTheme() {
  return ThemeData(
    primaryColor: Color(0xFF128C7E), // WhatsApp Dark Green
    scaffoldBackgroundColor: Color(0xFF121212), // Dark Background
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF128C7E),
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Color(0xFF25D366),
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  );
}

class MainScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  MainScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      QRGeneratorScreen(),
      QRScannerScreen(),
      AttendanceRecordsScreen(),
      ProfileScreen(
        toggleTheme: widget.toggleTheme,
        isDarkMode: widget.isDarkMode,
      ),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
      ),
    );
  }
}
