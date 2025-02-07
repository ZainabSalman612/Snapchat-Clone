import 'dart:math';
import 'package:flutter/material.dart';
import 'signup_page4.dart';
import 'package:camera/camera.dart'; // Import camera package

class UsernameSelectionScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final List<CameraDescription> cameras; // Add cameras parameter

  const UsernameSelectionScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.cameras, // Add this
  });

  @override
  _UsernameSelectionScreenState createState() => _UsernameSelectionScreenState();
}

class _UsernameSelectionScreenState extends State<UsernameSelectionScreen> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: _generateUsername());
  }

  String _generateUsername() {
    Random random = Random();
    int randomNumber = random.nextInt(90000) + 10000; // Generates a number between 10000-99999
    return "${widget.firstName.toLowerCase()}_${widget.lastName.toLowerCase()}$randomNumber";
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
                'Step 3 of 5',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Your username is",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Center(
              child: Text(
                _usernameController.text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _usernameController.text = _generateUsername();
                  });
                },
                child: const Text(
                  "Change my username",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Center(
              child: Text(
                "You will be able to change this later in Settings.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Proceed to the next step, passing cameras
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PasswordCreationScreen(cameras: widget.cameras),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
