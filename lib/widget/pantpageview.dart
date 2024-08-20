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
  Widget build(BuildContext context) {
    //double widthsize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
              width: widget.widthsize,
              height: 160,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  padEnds: false,
                  controller: widget._pageController,
                  itemCount: widget._result!.length,
                  itemBuilder: (context, index) {
                    String label = widget._result![index]['label'].toString();

                    String processedLabel =
                        label.replaceFirst(RegExp(r'^\d+\s*'), '');
                    return ValueListenableBuilder(
                        valueListenable: widget.currentPageNotifier,
                        builder: (context, currentPage, _) {
                          if (currentPage == index) {
                            String processedtext = widget._result![currentPage]
                                    ['label']
                                .toString();
                            currentLabel = processedtext.replaceFirst(
                                RegExp(r'^\d+\s*'), '');
                            debugPrint("label $currentLabel");
                          }
                          return plantdescriptions(processedLabel);
                        });
                  })),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
