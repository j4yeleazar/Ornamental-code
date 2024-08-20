import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('plants')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];
              return ListTile(
                title: Text(data['label']),
                subtitle: Text(
                    'Confidence: ${(data['confidence'] * 100).toStringAsFixed(2)}%'),
                leading: Image.file(File(data['imagePath'])),
                trailing:
                    Text(DateFormat.yMMMd().format(data['timestamp'].toDate())),
              );
            },
          );
        },
      ),
    );
  }
}
