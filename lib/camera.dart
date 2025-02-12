import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'gallery.dart';
import 'profile.dart';
import 'utils/colors.dart';

class SnapchatCameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const SnapchatCameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _SnapchatCameraScreenState createState() => _SnapchatCameraScreenState();
}

class _SnapchatCameraScreenState extends State<SnapchatCameraScreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  final List<String> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera(widget.cameras.first);
  }

  Future<void> _initializeCamera(CameraDescription camera) async {
    _cameraController = CameraController(camera, ResolutionPreset.high);
    await _cameraController.initialize();
    if (!mounted) return;
    setState(() => _isCameraInitialized = true);
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized) return;
    try {
      final XFile picture = await _cameraController.takePicture();
      setState(() {
        _capturedImages.add(picture.path);
      });
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> _switchCamera() async {
    if (!_isCameraInitialized) return;
    int currentIndex = widget.cameras.indexOf(_cameraController.description);
    int newIndex = (currentIndex + 1) % widget.cameras.length;

    await _cameraController.dispose();
    await _initializeCamera(widget.cameras[newIndex]);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: _isCameraInitialized
                ? CameraPreview(_cameraController)
                : const Center(child: CircularProgressIndicator()),
          ),

          // Top Icons
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.account_circle, color: themeColor, size: 40),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(cameras: widget.cameras)),
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                  onPressed: _switchCamera,
                ),
                IconButton(
                  icon: const Icon(Icons.music_note, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Camera Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_library, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryScreen(imagePaths: _capturedImages),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 15),

                // Navigation Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: const Icon(Icons.map, color: Colors.white), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.chat, color: Colors.white), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.explore, color: Colors.white), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.video_library, color: Colors.white), onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
