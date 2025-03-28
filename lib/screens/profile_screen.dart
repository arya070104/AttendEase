import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  ProfileScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile & Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.teal),
            SizedBox(height: 20),
            Text(
              'Your Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (value) {
                toggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
