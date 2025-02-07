import 'package:flutter/material.dart';
import 'signup_page5.dart';

class PasswordCreationScreen extends StatefulWidget {
  @override
  _PasswordCreationScreenState createState() => _PasswordCreationScreenState();
}

class _PasswordCreationScreenState extends State<PasswordCreationScreen> {
  late TextEditingController _passwordController;
  bool _obscureText = true;
  bool _isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();

    // Listen for changes in the password field to check validity
    _passwordController.addListener(() {
      setState(() {
        // Check if the password has at least 8 characters
        _isPasswordValid = _passwordController.text.length >= 8;
      });
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
                'Step 4 of 5',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Set a password",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,  // Hides text with bullets
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;  // Toggle visibility
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "Your password should be at least 8 characters",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isPasswordValid
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailSignupScreen(),
                        ),
                      );
                    }
                  : null,  // Button is disabled if password is invalid
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPasswordValid ? Colors.blue : Colors.grey, // Change color based on validity
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 16, color: Colors.white),  // Make text white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
