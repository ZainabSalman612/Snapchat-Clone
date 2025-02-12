import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page1.dart';
import 'package:camera/camera.dart';
import 'utils/colors.dart';

class Home extends StatelessWidget {
  final List<CameraDescription> cameras;
  
  const Home({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'logo.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          Column(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(cameras: cameras),
                      ),
                    );
                  },
                  child: Container(
                    color: accentColorRed,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const Center(
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(cameras: cameras)
                      ),
                    );
                  },
                  child: Container(
                    color: accentColorBlue,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
