import 'package:flutter/material.dart';

class Carecard extends StatelessWidget {
  final String titlee;
  final String caredesc;
  final Icon icontype;

  const Carecard({
    super.key,
    required this.titlee,
    required this.caredesc,
    required this.icontype,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      surfaceTintColor: Colors.white, // Reduced elevation for subtle shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icontype, // Icon displayed at the left
            const SizedBox(width: 10), // Space between icon and text
            Expanded(
              // To handle long text gracefully
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titlee,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                      height: 5), // Spacing between title and description
                  Text(
                    caredesc,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
