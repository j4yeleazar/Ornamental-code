import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ornamental/model/savefav.dart';
import 'package:provider/provider.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  Map<String, dynamic>? selectedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bookmarkState = Provider.of<BookmarkState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 19),
        backgroundColor: const Color(0xFF1B5E20),
        title: const Text("Saved Page"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  selectedItem = null;
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: selectedItem == null
              ? Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bookmarkState.bookmarkedItems.length,
                        itemBuilder: (context, index) {
                          var item = bookmarkState.bookmarkedItems.keys
                              .toList()[index];
                          var bookmarkedItem =
                              bookmarkState.bookmarkedItems[item];
                          String processedLabel = bookmarkedItem!['title']
                              .replaceFirst(RegExp(r'^\d+\s*'), '');

                          return ListTile(
                            tileColor: Colors.white,
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: ClipOval(
                                  child: Image.file(
                                      fit: BoxFit.cover,
                                      File(bookmarkedItem['path']))),
                            ),
                            title: Text(processedLabel),
                            subtitle: Text(
                              "${bookmarkedItem['disc']}\n${bookmarkedItem['description']}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                bookmarkState
                                    .toogleRemove("${bookmarkedItem['id']}");
                                deleteImage('${bookmarkedItem['path']}');
                                setState(() {});
                              },
                            ),
                            onTap: () {
                              // Set the selected item to view details within the same page
                              setState(() {
                                selectedItem = bookmarkedItem;
                              });
                            },
                          );
                        })
                  ],
                )
              : _buildDetailsView(selectedItem!),
        ),
      ),
    );
  }

  // Function to build the details view
  Widget _buildDetailsView(Map<String, dynamic> item) {
    String processedLabel = item['title'].replaceFirst(RegExp(r'^\d+\s*'), '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.file(File(item['path'])),
        const SizedBox(height: 10),
        Text(
          processedLabel,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          item['disc'],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
          item['description'],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedItem = null;
            });
          },
          child: const Text('Back to Saved Items'),
        ),
      ],
    );
  }

  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        debugPrint('Deleted image: $imagePath');
      } else {
        debugPrint('Image not found: $imagePath');
      }
    } catch (e) {
      debugPrint('Error deleting image: $e');
    }
  }
}
