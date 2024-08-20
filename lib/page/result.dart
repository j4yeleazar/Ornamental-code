import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ornamental/model/savefav.dart';
import 'package:ornamental/page/savepage.dart';
import 'package:ornamental/utils/functions.dart';
import 'package:ornamental/widget/panelgraph.dart';
import 'package:ornamental/widget/pantpageview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ShowResult extends StatefulWidget {
  final XFile selectedimage;
  final File? imageselect;
  final bool ishome;

  const ShowResult({
    super.key,
    required this.selectedimage,
    this.imageselect,
    required this.ishome,
  });

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  late PageController _pageController;
  List? _result = [];
  bool isloading = false;
  int? currentlabel;
  String? errorMessage;
  String? currentLabelint;
  bool issaving = false;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  Future<void> loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  Future<void> imageClassification() async {
    try {
      var imgClassification = await Tflite.runModelOnImage(
        path: widget.ishome == true
            ? widget.selectedimage.path
            : widget.imageselect!.path,
        numResults: 14,
        threshold: 0.03,
        imageMean: 127.5,
        imageStd: 127.5,
        asynch: true,
      );
      setState(() {
        _result = imgClassification!;
        isloading = false;
      });

      debugPrint("$_result");
    } catch (error) {
      debugPrint('$error');
    }
  }

  @override
  void initState() {
    loadModel();
    super.initState();
    initloadedimage();
    _pageController = PageController(initialPage: 0, viewportFraction: .75);
    _pageController.addListener(() {
      _currentPageNotifier.value = _pageController.page?.round() ?? 0;
    });
    _currentPageNotifier.addListener(() {
      _updateCurrentLabel();
    });
  }

  @override
  void dispose() {
    _currentPageNotifier.removeListener(() {
      _updateCurrentLabel();
    });
    super.dispose();
  }

  void resultonlyone() {
    if (_result!.length == 1) {
      debugPrint("true");
    }
  }

  void _updateCurrentLabel() {
    int currentPage = _currentPageNotifier.value;
    setState(() {
      debugPrint("current Page $currentPage");
      if (_result == null || _result!.isEmpty) {
        debugPrint("No results available.");
        currentLabelint = "No result";
      } else {
        if (currentPage < _result!.length) {
          String processedText = _result![currentPage]['label'].toString();
          currentLabelint = processedText.replaceFirst(RegExp(r'^\d+\s*'), '');
        } else {
          String processedText = _result!.first['label'].toString();
          currentLabelint = processedText.replaceFirst(RegExp(r'^\d+\s*'), '');
        }
        debugPrint("Page $currentLabelint");
      }
    });
  }

  void initloadedimage() {
    setState(() {
      isloading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      imageClassification();
    });
  }

  Future<void> savePlantResult(String plantName, double accuracy,
      String imagePath, String description) async {
    // Reference to the Firestore collection
    CollectionReference plantResults =
        FirebaseFirestore.instance.collection('plant_results');

    // Add a new document with the plant's result
    await plantResults.add({
      'plant_name': plantName,
      'accuracy': accuracy,
      'image_path': imagePath,
      'description': description, // Include description
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> handlesave() async {
    setState(() {
      issaving = true;
    });

    var bookmarkState = Provider.of<BookmarkState>(context, listen: false);
    try {
      String formattedDate = DateFormat.yMMMMd().format(DateTime.now());
      String formattedDisc = 'Save $formattedDate';
      int randomid = generateTwoDigitRandomNumber();
      final directory = await getApplicationDocumentsDirectory();
      final localSaveDirectory = Directory('${directory.path}/localsave');
      if (!await localSaveDirectory.exists()) {
        await localSaveDirectory.create(recursive: true);
      }

      String randomLetters = generateRandomLetters(5);
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String imagePath =
          '${localSaveDirectory.path}/$randomLetters-$timestamp.png';

      final File imageFile = File(widget.selectedimage.path);
      await imageFile.copy(imagePath);
      debugPrint(imagePath);

      // Define the description
      String description = "Description for ${_result![0]['label']}";

      // Save to Firestore with the description
      await savePlantResult(
        _result![0]['label'],
        _result![0]['confidence'],
        imagePath,
        description, // Pass description here
      );

      // Save the bookmark locally with the description
      bookmarkState.toggleBookmark(
        id: "${_result![0]['label']}$randomid",
        path: imagePath,
        title: "${_result![0]['label']}",
        disc: formattedDisc,
        description: description, // Add description here
      );

      debugPrint("save");

      setState(() {
        issaving = false;
      });
    } catch (e) {
      debugPrint("Error saving file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Color(0xff88B648), shape: BoxShape.circle),
        child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SavePage()));
            },
            icon: const Icon(
              Icons.bookmark_outline,
              color: Colors.white,
            )),
      ),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff88B648),
        automaticallyImplyLeading: false,
        title: const Text(
          "Ornamental Plants",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.camera_outlined,
                color: Colors.white,
              )),
          // IconButton(
          //     onPressed: () {
          //       setState(() {});
          //     },
          //     icon: const Icon(
          //       Icons.refresh,
          //       color: Colors.white,
          //     ))

          issaving == false
              ? IconButton(
                  onPressed: () {
                    handlesave();
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                  ))
              : const LoadingAnimation(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            height: 190,
            width: widthsize,
            decoration: const BoxDecoration(
                color: Color(0xff88B648),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: widget.selectedimage.path.isNotEmpty
                        ? Container(
                            height: 169,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image:
                                    FileImage(File(widget.selectedimage.path)),
                                fit: BoxFit
                                    .cover, // Adjust the fit as per your requirement
                              ),
                            ))
                        : Container(
                            height: 169,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage('assets/image/plant.png'),
                                fit: BoxFit
                                    .cover, // Adjust the fit as per your requirement
                              ),
                            ))),
                const SizedBox(width: 10),
                Expanded(
                    child: isloading == true
                        ? const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LinearProgressIndicator(),
                              SizedBox(
                                child: Text(
                                  "Analyzing your image Please Wait",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _result!.length,
                            itemBuilder: (context, index) {
                              if (index >= 3) {
                                return const SizedBox.shrink();
                              }
                              double valueaccuracy =
                                  _result![index]['confidence'];
                              String accurary =
                                  (valueaccuracy * 100).toStringAsFixed(0);
                              String label =
                                  _result![index]['label'].toString();

                              String processedLabel =
                                  label.replaceFirst(RegExp(r'^\d+\s*'), '');
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      processedLabel,
                                      style: TextStyle(
                                          fontSize:
                                              _result!.length > 1 ? 16 : 20,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Accuracy: $accurary%",
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            }))
              ],
            ),
          ),
          const SizedBox(height: 10),
          PageViewPlant(
              widthsize: widthsize,
              currentPageNotifier: _currentPageNotifier,
              pageController: _pageController,
              result: _result),

          // ValueListenableBuilder(valueListenable: _currentPageNotifier, builder: (context, current,_){
          //   if(current)
          // })
          currentLabelint != null || currentLabelint == "No result"
              ? panelGraph(currentLabelint!, widthsize)
              : const Text("No Result")
        ],
      ),
    );
  }
}
