import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  final List<String> imagePaths; // List of images from backend

  const GalleryScreen({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Memories",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline, color: Colors.black, size: 25),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              cursorColor: Colors.blue, // Set cursor color to blue
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 225, 220, 220),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Tab options
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: ["Home", "Camera Roll", "AI Snaps", "Stories", "My Eyes Only"]
                  .map((tab) => _buildTab(tab, tab == "Home"))
                  .toList(),
            ),
          ),

          // Gallery Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 columns like Snapchat
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: imagePaths.length, // Dynamic image count
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey, // Set the background color to grey
                  child: _buildGalleryItem(imagePaths[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  // Tab button widget
  Widget _buildTab(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Gallery item (Dynamic Images)
  Widget _buildGalleryItem(String imagePath) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
