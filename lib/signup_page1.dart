import 'package:flutter/material.dart';
import 'signup_page2.dart';
import 'package:camera/camera.dart'; // Import camera package

class SignupPage extends StatefulWidget {
  final List<CameraDescription> cameras; // Add cameras parameter

  const SignupPage({super.key, required this.cameras});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool get _isSignupEnabled =>
      _firstNameController.text.isNotEmpty && _lastNameController.text.isNotEmpty;

  void _goToBirthdaySelection() {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BirthdaySelectionScreen(
          firstName: firstName,
          lastName: lastName,
          cameras: widget.cameras, // Pass cameras here
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(() {
      setState(() {});
    });
    _lastNameController.addListener(() {
      setState(() {});
    });
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
                'Step 1 of 5',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _firstNameController,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                labelText: 'First name',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                labelText: 'Last name',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'By tapping "Continue", you acknowledge that you have read the Privacy Policy and agree to the Terms of Service.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isSignupEnabled ? _goToBirthdaySelection : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isSignupEnabled ? Colors.blue : Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
