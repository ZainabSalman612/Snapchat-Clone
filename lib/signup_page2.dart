import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signup_page3.dart';
import 'package:camera/camera.dart';

class BirthdaySelectionScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final List<CameraDescription> cameras;

  const BirthdaySelectionScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.cameras,
  });

  @override
  _BirthdaySelectionScreenState createState() => _BirthdaySelectionScreenState();
}

class _BirthdaySelectionScreenState extends State<BirthdaySelectionScreen> {
  DateTime _selectedDate = DateTime(2000, 1, 1);
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _birthdayController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  void _updateBirthdayTextField(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _birthdayController.text = DateFormat('yyyy-MM-dd').format(newDate);
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
                'Step 2 of 5',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Birthday",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _birthdayController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                maximumDate: DateTime.now(),
                minimumYear: 1900,
                maximumYear: DateTime.now().year,
                onDateTimeChanged: _updateBirthdayTextField,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsernameSelectionScreen(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      birthday: _birthdayController.text, // ✅ Fix: Pass birthday
                      cameras: widget.cameras,
                    ),
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
                'Continue',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
