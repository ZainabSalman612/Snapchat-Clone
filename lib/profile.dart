import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Required for DateFormat
import 'home.dart';
import 'package:camera/camera.dart';

class ProfileScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ProfileScreen({
    Key? key, 
    required this.cameras
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = "";
  String lastName = "";
  String username = "";
  String birthday = "";
  String zodiacSign = "";
  String avatar = ""; // Ensure avatar is always a string
  int snapScore = 185634; // Default or random value (change if needed)
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Fetching user profile for UID: ${user.uid}"); // Debug log
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          print("User profile found: ${userDoc.data()}"); // Debug log
          setState(() {
            firstName = userDoc['firstName'] ?? "";
            lastName = userDoc['lastName'] ?? "";
            username = userDoc['username'] ?? "";
            birthday = userDoc['birthday'] ?? "";
            avatar = userDoc['avatar'] ?? ""; // Ensure avatar is fetched
            zodiacSign = _calculateZodiac(birthday);
            isLoading = false;
            
            // Format the birthday to "D MMM" (e.g., "9 Feb")
            if (birthday.isNotEmpty) {
              DateTime date = DateTime.parse(birthday);
              birthday = DateFormat('d MMM').format(date); // Update birthday format here
            }
          });
        } else {
          print("User document does not exist"); // Debug log
        }
      } catch (e) {
        print("Error fetching user profile: $e"); // Error log
      }
    } else {
      print("No user is logged in"); // Debug log
    }
  }

  String _calculateZodiac(String birthDate) {
    if (birthDate.isEmpty) return "";
    DateTime date = DateTime.parse(birthDate);
    int day = date.day;
    int month = date.month;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "Aquarius";
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return "Pisces";
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "Aries";
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "Taurus";
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return "Gemini";
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return "Cancer";
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "Leo";
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "Virgo";
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return "Libra";
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return "Scorpio";
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return "Sagittarius";
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return "Capricorn";
    return "";
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home(cameras: widget.cameras)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Display Avatar
                        if (avatar.isNotEmpty)
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/$avatar.jpg"),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          "$firstName $lastName",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          username,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow
                              ),
                              onPressed: () {},
                              child: const Text("My Account", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:Colors.yellow),
                              onPressed: () {},
                              child: const Text("Public Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Birthday, Snapscore, and Zodiac Row
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.cake, color: Colors.red),
                            const SizedBox(width: 4),
                            Text(birthday, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.blue),
                            SizedBox(width: 4),
                            Text("185,634", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.purple),
                            const SizedBox(width: 4),
                            Text(zodiacSign, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Log Out",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
