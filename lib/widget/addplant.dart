import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPlant extends StatefulWidget {
  const AddNewPlant({super.key});

  @override
  State<AddNewPlant> createState() => _AddNewPlantState();
}

class _AddNewPlantState extends State<AddNewPlant> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

      if (photo != null) {
        setState(() {
          _selectedImage = File(photo.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected.'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error taking photo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to take photo. Please try again.'),
        ),
      );
    }
  }

  Future<void> _submitPlant() async {
    if (_selectedImage == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a photo and fill in the description.'),
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    try {
      // Ensure Firebase is initialized
      await Firebase.initializeApp();

      // Upload the image file to Firebase Storage with progress
      await _uploadImageToFirebaseStorage(_selectedImage!);

      // Get reference to the Firestore collection
      CollectionReference plantsForModeration =
          FirebaseFirestore.instance.collection('plants_for_moderation');

      // Add the new plant entry to Firestore (without imageUrl)
      await plantsForModeration.add({
        'description': _descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending', // For admin to check and approve
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Plant submitted for moderation.'),
        ),
      );

      // Clear the form after successful submission
      _clearForm();
    } catch (e) {
      debugPrint('Error submitting plant: $e');
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit plant. Please try again.'),
        ),
      );
    }
  }

  Future<void> _uploadImageToFirebaseStorage(File imageFile) async {
    try {
      if (!imageFile.existsSync()) {
        throw 'Image file not found';
      }

      // Generate a unique filename using the current timestamp
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Create a reference to the Firebase Storage location where you want to upload the image
      final ref = FirebaseStorage.instance
          .ref()
          .child('plants_for_moderation/$fileName');

      // Upload the file to Firebase Storage with progress tracking
      UploadTask uploadTask = ref.putFile(imageFile);

      // Monitor the upload task and update progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        });
      });

      // Wait for the upload to complete
      await uploadTask;
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException during image upload: ${e.message}');
      throw 'Failed to upload image: ${e.message}';
    } catch (e) {
      debugPrint('Unknown error during image upload: $e');
      throw 'Could not upload image due to an unknown error.';
    }
  }

  void _clearForm() {
    setState(() {
      _descriptionController.clear();
      _selectedImage = null;
      _isUploading = false;
      _uploadProgress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 19),
        backgroundColor: const Color(0xFF1B5E20),
        title: const Text('Add New Plant'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _selectedImage == null
                ? const Text('No image selected.')
                : Container(
                    height: 200, // Fixed height for the image container
                    width: double.infinity, // Full width of the container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover, // Contain image within the container
                      ),
                    ),
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _takePhoto,
              child: const Text('Select Photo'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Plant Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            _isUploading
                ? Column(
                    children: [
                      Text(
                        'Uploading... ${_uploadProgress.toStringAsFixed(0)}%', // Show percentage progress
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: _uploadProgress / 100, // Show progress bar
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: _submitPlant,
                    child: const Text('Add This Plant'),
                  ),
          ],
        ),
      ),
    );
  }
}
