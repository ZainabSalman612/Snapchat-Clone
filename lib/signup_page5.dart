import 'package:flutter/material.dart';
import 'package:snapchat/camera.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailSignupScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String firstName;
  final String lastName;
  final String birthday;
  final String username;
  final String password;
  final String avatar;

  const EmailSignupScreen({
    super.key,
    required this.cameras,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.username,
    required this.password,
    required this.avatar,
  });

  @override
  _EmailSignupScreenState createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  late TextEditingController _emailController;
  bool _isEmailValid = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();

    // Validate email on change
    _emailController.addListener(() {
      setState(() {
        _isEmailValid = RegExp(
                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
            .hasMatch(_emailController.text);
      });
    });
  }

  Future<void> registerUser() async {
    if (!_isEmailValid) return;

    setState(() {
      _isLoading = true;
    });

    print("➡️ Starting user registration...");

    try {
      // Step 1: Create user in Firebase Authentication
      print("🔵 Creating user in Firebase Authentication...");
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: widget.password,
      );

      print("✅ User created: ${userCredential.user!.uid}");

      // Step 2: Save user details in Firestore
      print("🟢 Saving user data in Firestore...");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': widget.firstName,
        'lastName': widget.lastName,
        'birthday': widget.birthday,
        'username': widget.username,
        'email': _emailController.text.trim(),
        'avatar': widget.avatar, // ✅ Save avatar
      });

      print("✅ User data saved in Firestore");

      // Step 3: Navigate to Camera Screen
      print("🎥 Navigating to SnapchatCameraScreen...");
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SnapchatCameraScreen(cameras: widget.cameras),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuthException: ${e.code} - ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Auth Error: ${e.message}")),
      );
    } on FirebaseException catch (e) {
      print("❌ Firestore Error: ${e.code} - ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Firestore Error: ${e.message}")),
      );
    } catch (e) {
      print("❌ Unexpected Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected Error: ${e.toString()}")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        print("🔄 Finished execution, loading state reset.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Create account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Step 5 of 5',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                labelText: 'Enter your email',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isEmailValid && !_isLoading
                  ? registerUser
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isEmailValid ? Colors.blue : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Finish",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
