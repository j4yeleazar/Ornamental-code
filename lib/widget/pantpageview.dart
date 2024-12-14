import 'package:flutter/material.dart';
import 'package:ornamental/utils/functions.dart';

class PageViewPlant extends StatefulWidget {
  const PageViewPlant({
    super.key,
    required this.widthsize,
    required PageController pageController,
    required List? result,
    required this.currentPageNotifier,
  })  : _pageController = pageController,
        _result = result;

  final double widthsize;
  final PageController _pageController;
  final List? _result;
  final ValueNotifier<int> currentPageNotifier;

  @override
  State<PageViewPlant> createState() => _PageViewPlantState();
}

class _PageViewPlantState extends State<PageViewPlant> {
  String? currentLabel;

  @override
  void initState() {
    super.initState();
    // Sort the result to get the top confidence result first
    if (widget._result != null && widget._result!.isNotEmpty) {
      widget._result!
          .sort((a, b) => b['confidence'].compareTo(a['confidence']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description Section
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 46, 78, 2),
              ),
            ),
          ),
          SizedBox(
            width: widget.widthsize,
            height: 160,
            child: widget._result != null && widget._result!.isNotEmpty
                ? plantdescriptions(
                    widget._result!.first['label']
                        .toString()
                        .replaceFirst(RegExp(r'^\d+\s*'), ''),
                  )
                : const Text("No Result Found"),
          ),
          const SizedBox(height: 30),

          // Care Section
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Care",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 46, 78, 2),
              ),
            ),
          ),
          SizedBox(
            width: widget.widthsize,
            height: 160,
            child: widget._result != null && widget._result!.isNotEmpty
                ? plantCare(
                    widget._result!.first['label']
                        .toString()
                        .replaceFirst(RegExp(r'^\d+\s*'), ''),
                  )
                : const Text("Care information is not available."),
          ),
        ],
      ),
    );
  }
}
