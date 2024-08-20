import 'package:flutter/material.dart';

class TakeaPhoto extends StatelessWidget {
  final Function imageselected;

  const TakeaPhoto({super.key, required this.imageselected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F3F0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Good Day!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Centered Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  imageselected();
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                label: const Text(
                  "Take a Photo",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF69C33),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  minimumSize: const Size(180, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
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
