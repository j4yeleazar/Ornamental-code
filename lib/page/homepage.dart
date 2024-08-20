import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ornamental/page/savepage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ornamental/page/result.dart';
import 'package:ornamental/widget/takephoto.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imagepath;
  bool isload = false;
  int _selectedIndex = 0;

  Future<void> handlepickImagedata() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (!mounted) return;

    if (image != null) {
      setState(() {
        imagepath = image;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowResult(
              selectedimage: imagepath!,
              ishome: true,
            ),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  Future<bool> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses[Permission.camera]!.isGranted &&
        statuses[Permission.storage]!.isGranted;
  }

  @override
  void initState() {
    _requestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F3F0),
      body:
          _buildPage(), // Display the current page based on the selected index
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.orange,
          tabBackgroundColor: Colors.grey.shade200,
          gap: 8,
          padding: const EdgeInsets.all(16),
          selectedIndex: _selectedIndex, // Bind the selected index
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.history, text: 'History'),
            GButton(icon: Icons.bookmarks, text: 'Saved'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return TakeaPhoto(
          imageselected: handlepickImagedata,
        );
      case 1:
        return const Center(child: Text('History Page'));
      case 2:
        return const SavePage();
      case 3:
        return const Center(child: Text('Profile Page'));
      default:
        return const Center(child: Text('Page not found'));
    }
  }
}
