import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme; // Add this parameter

  const TeacherProfileScreen({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  void _logout(BuildContext context) async {
    bool confirmLogout = await _showLogoutConfirmation(context);
    if (confirmLogout) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<bool> _showLogoutConfirmation(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Logout", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Profile")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 100, color: Colors.green),
          const SizedBox(height: 20),
          const Text("Teacher Name", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: widget.isDarkMode,
            onChanged: widget.toggleTheme, // Now toggleTheme is passed correctly
            secondary: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
