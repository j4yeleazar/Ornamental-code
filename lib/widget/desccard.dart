import 'package:flutter/material.dart';

class Descriptioncard extends StatelessWidget {
  final String tittle;
  final String description;
  final String planttype;
  final Icon icontype;
  const Descriptioncard(
      {super.key,
      required this.tittle,
      required this.description,
      required this.planttype,
      required this.icontype});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icontype,
            Text(
              tittle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              planttype,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              description,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
