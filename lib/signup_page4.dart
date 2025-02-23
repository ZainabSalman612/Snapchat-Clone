import 'package:flutter/material.dart';
import 'signup_page5.dart';
import 'package:camera/camera.dart'; // Import camera package


class PasswordCreationScreen extends StatefulWidget {
  final List<CameraDescription> cameras; // Add cameras parameter
  final String firstName;
  final String lastName;
  final String birthday;
  final String username;
  final String avatar;

  const PasswordCreationScreen({
    super.key,
    required this.cameras,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.username,
    required this.avatar,
  });

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

    _passwordController.addListener(() {
      setState(() {

        _isPasswordValid = _passwordController.text.length >= 8;
      });
    });
  }

  Future<void> _createUser() async {
    try {
      print("User created: \${userCredential.user?.uid}");
    } catch (e) {
      print("Error creating user: \$e");
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
              obscureText: _obscureText,
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
                      _obscureText = !_obscureText; 
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
                  ? () async {
                      await _createUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailSignupScreen(
                            cameras: widget.cameras,
                            firstName: widget.firstName,
                            lastName: widget.lastName,
                            birthday: widget.birthday,
                            username:widget.username,
                            password: _passwordController.text,
                            avatar: widget.avatar,
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPasswordValid ? Colors.blue : Colors.grey,
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
