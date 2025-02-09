import 'package:flutter/material.dart';
import 'signup_page4.dart';
import 'package:camera/camera.dart';

class AvatarSelectionScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String firstName;
  final String lastName;
  final String birthday;
  final String username;

  const AvatarSelectionScreen({
    Key? key,
    required this.cameras,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.username,
  }) : super(key: key);

  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  String selectedAvatar = "";

  void _selectAvatar(String avatar) {
    setState(() {
      selectedAvatar = avatar;
    });
  }

  void _continue() {
    if (selectedAvatar.isNotEmpty) {
      // ✅ Pass avatar to signup_page4.dart (not Firestore yet)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordCreationScreen(
            cameras: widget.cameras,
            firstName: widget.firstName,
            lastName: widget.lastName,
            birthday: widget.birthday,
            username: widget.username,
            avatar: selectedAvatar,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an avatar"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Choose your avatar",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAvatarOption("male", "male.jpg"),
              const SizedBox(width: 20),
              _buildAvatarOption("female", "female.jpg"),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarOption(String avatarType, String imagePath) {
    return InkWell(
      onTap: () => _selectAvatar(avatarType),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedAvatar == avatarType ? Colors.blue : Colors.transparent,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(imagePath, width: 150),
      ),
    );
  }
}
