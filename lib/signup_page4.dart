import 'package:flutter/material.dart';

class PasswordCreationScreen extends StatefulWidget {
  @override
  _PasswordCreationScreenState createState() => _PasswordCreationScreenState();
}

class _PasswordCreationScreenState extends State<PasswordCreationScreen> {
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
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
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 15.0,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
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
              onPressed: () {
                // Proceed to the next step
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NextScreen(), // Replace with actual next screen
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
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

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Next Screen Placeholder"),
      ),
    );
  }
}
