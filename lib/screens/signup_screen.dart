import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _errorMessage;
  String _selectedRole = 'student'; // Default role

  // 🔹 **Sign up with email and password**
  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // ✅ **Create User in Firebase Authentication**
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        // ✅ **Generate Unique QR Code Data (UID-based)**
        String qrCodeData = "attendease_${user.uid}";

        // ✅ **Store User Data in Firestore**
        Map<String, dynamic> userData = {
          'email': user.email,
          'role': _selectedRole,
        };

        if (_selectedRole == 'student') {
          userData['rollNumber'] = _rollNumberController.text.trim();
          userData['qrCode'] = qrCodeData; // 🔥 Store QR Code in Firestore
        }

        await _firestore.collection('users').doc(user.uid).set(userData);

        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
      }

      // ✅ **Show Email Verification Alert**
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Verify Your Email"),
          content: Text("A verification email has been sent to ${_emailController.text}."),
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

  // 🔹 **Google Sign-In**
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // ✅ **Ensure QR Code is generated for students**
        String qrCodeData = "attendease_${user.uid}";

        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'role': _selectedRole,
          if (_selectedRole == 'student') 'qrCode': qrCodeData,
        }, SetOptions(merge: true));

        Navigator.pushReplacementNamed(context, _selectedRole == 'teacher' ? '/teacher-dashboard' : '/student-dashboard');
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Select Role:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 'student',
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      },
                    ),
                    Text("Student"),
                    Radio(
                      value: 'teacher',
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      },
                    ),
                    Text("Teacher"),
                  ],
                ),

                if (_selectedRole == 'student') // Show roll number for students
                  TextFormField(
                    controller: _rollNumberController,
                    decoration: InputDecoration(labelText: "Roll Number"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter your roll number";
                      return null;
                    },
                  ),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please enter your email";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please enter a password";
                    if (value.length < 6) return "Password must be at least 6 characters";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: "Confirm Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) return "Passwords do not match";
                    return null;
                  },
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
                        child: Text("Sign Up"),
                      ),
                SizedBox(height: 10),

                // 🔹 Google Sign-In Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  icon: Image.asset('assets/google_logo.png', height: 24),
                  label: Text("Sign in with Google", style: TextStyle(color: Colors.black)),
                  onPressed: _signInWithGoogle,
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
        ),
      ),
    );
  }
}
