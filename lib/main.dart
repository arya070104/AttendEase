import 'package:attendease/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/qr_generator_screen.dart';
import 'screens/qr_scanner_screen.dart';
import 'screens/attendance_records_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        User? user = snapshot.data;
        bool isEmailVerified = user?.emailVerified ?? false;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AttendEase',
          theme: _isDarkMode ? _darkTheme() : _lightTheme(),
          initialRoute: (user == null)
              ? '/welcome'
              : (isEmailVerified ? '/home' : '/login'),
          routes: {
            '/welcome': (context) => WelcomeScreen(),
            '/login': (context) => LoginScreen(),
            '/signup': (context) => SignupScreen(),
            '/forgot-password': (context) => ForgotPasswordScreen(),
            '/home': (context) =>
                MainScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
          },
        );
      },
    );
  }
}

// WhatsApp Light Theme
ThemeData _lightTheme() {
  return ThemeData(
    primaryColor: Color(0xFF075E54),
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
    primaryColor: Color(0xFF128C7E),
    scaffoldBackgroundColor: Color(0xFF121212),
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
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Generate QR'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan QR'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Records'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
      ),
    );
  }
}

