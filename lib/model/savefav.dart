import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkState extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _bookmarkedItems = {};
  late SharedPreferences _prefs;

  Map<String, Map<String, dynamic>> get bookmarkedItems => _bookmarkedItems;

  BookmarkState() {
    _initializeBookmarks();
  }

  void _initializeBookmarks() async {
    debugPrint("hello");
    _prefs = await SharedPreferences.getInstance();
    await _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final jsonString = _prefs.getString('bookmarks');
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      _bookmarkedItems = Map<String, Map<String, dynamic>>.from(jsonData);
    }
  }

  void _saveBookmarks() {
    final jsonString = json.encode(_bookmarkedItems);
    _prefs.setString('bookmarks', jsonString);
  }

  void toogleRemove(String id) {
    _bookmarkedItems.remove(id);
    _saveBookmarks();
    notifyListeners();
  }

  void toggleBookmark({
    required String id,
    required String title,
    required String path,
    required String disc,
    required String description, // Add the description parameter
  }) {
    if (_bookmarkedItems.containsKey(id)) {
      _bookmarkedItems.remove(id);
    } else {
      _bookmarkedItems[id] = {
        'title': title,
        'path': path,
        'disc': disc,
        'description': description, // Store the description
        'id': id,
      };
    }
    _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(String id) {
    return _bookmarkedItems.containsKey(id);
  }
}
