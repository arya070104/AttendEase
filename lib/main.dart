import 'package:attendease/firebase_options.dart';
import 'package:attendease/screens/edit_attendance_screen.dart';
import 'package:attendease/screens/qr_scanner_screen.dart';
import 'package:attendease/screens/teacher_profile_screen.dart'; // Added Profile Screen Import
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/student_dashboard.dart';
import 'screens/teacher_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Load saved theme preference
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(AttendEaseApp(isDarkMode: isDarkMode));
}

class AttendEaseApp extends StatefulWidget {
  final bool isDarkMode;
  const AttendEaseApp({super.key, required this.isDarkMode});

  @override
  _AttendEaseAppState createState() => _AttendEaseAppState();
}

class _AttendEaseAppState extends State<AttendEaseApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  /// 🔹 **Toggle Dark Mode and Save Preference**
  void toggleTheme(bool value) async {
    setState(() => isDarkMode = value);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AttendEase',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF075E54),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF075E54),
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Apply theme mode
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthHandler(), // Handles login redirection
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/student-dashboard': (context) => StudentDashboard(isDarkMode: isDarkMode,
  toggleTheme: toggleTheme,),
        '/teacher-dashboard': (context) => TeacherDashboard(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
        '/edit-attendance': (context) => EditAttendanceScreen(),
        '/qrScanner': (context) => QRScannerScreen(),
        '/teacher-profile': (context) => TeacherProfileScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode), // Pass function and state
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Page Not Found", style: TextStyle(fontSize: 20))),
          ),
        );
      },
    );
  }
}

/// 🔹 **AuthHandler: Determines user role and redirects accordingly**
class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user == null) return const WelcomeScreen(); // Not logged in

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Loading state
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Error loading user data"));
            }

            final userData = snapshot.data?.data() as Map<String, dynamic>?;

            if (userData == null || !userData.containsKey('role')) {
              return const WelcomeScreen(); // Handle case where role is missing
            }

            final role = userData['role'];

            if (role == 'student') {
              final appState = context.findAncestorStateOfType<_AttendEaseAppState>();

if (appState == null) {
  return const WelcomeScreen(); // Fallback if state is not found
}

return StudentDashboard(
  isDarkMode: appState.isDarkMode,
  toggleTheme: appState.toggleTheme,
);

            } else if (role == 'teacher') {
              final appState = context.findAncestorStateOfType<_AttendEaseAppState>();

if (appState == null) {
  return const WelcomeScreen(); // Fallback if state is not found
}

return TeacherDashboard(
  isDarkMode: appState.isDarkMode,
  toggleTheme: appState.toggleTheme,
);

            } else {
              return const WelcomeScreen(); // Default fallback
            }
          },
        );
      },
    );
  }
}
