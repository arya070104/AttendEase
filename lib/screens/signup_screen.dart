import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signup() async {
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      setState(() {
        _errorMessage = "Passwords do not match!";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Verify Your Email"),
          content: Text("A verification email has been sent to ${_emailController.text}. Please verify your email before logging in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: "Confirm Password"),
              obscureText: true,
            ),
            SizedBox(height: 16),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF25D366),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

