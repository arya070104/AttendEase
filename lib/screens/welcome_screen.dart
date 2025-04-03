import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF075E54), // WhatsApp Green
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to AttendEase',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 🔹 Login as Student
            _buildButton(
              text: 'Login as Student',
              color: const Color(0xFF25D366),
              onPressed: () => Navigator.pushReplacementNamed(context, '/studentLogin'),
            ),

            const SizedBox(height: 20),

            // 🔹 Login as Teacher
            _buildButton(
              text: 'Login as Teacher',
              color: const Color(0xFF128C7E),
              onPressed: () => Navigator.pushReplacementNamed(context, '/teacherLogin'),
            ),

            const SizedBox(height: 20),

            // 🔹 Sign Up
            _buildButton(
              text: 'Sign Up',
              color: const Color(0xFF128C7E),
              onPressed: () => Navigator.pushReplacementNamed(context, '/signup'),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable Button Widget
  Widget _buildButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
