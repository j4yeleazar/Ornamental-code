// import 'dart:io';

// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:lostfoundapp/mics/packages.dart';
// import 'package:permission_handler/permission_handler.dart';

// XFile? imagepathfile;

// Color squarecolor = primaryColor;
// String? itemcolorValue;

// class ImageClassification extends StatefulWidget {
//   const ImageClassification(
//       {super.key, required this.itemcolorcon, required this.itemtitlecon});
//   final TextEditingController itemcolorcon;

//   final TextEditingController itemtitlecon;

//   @override
//   State<ImageClassification> createState() => _ImageClassificationState();
// }

// class _ImageClassificationState extends State<ImageClassification> {
//   String pixelcolor = "";
//   List _result = [];
//   String imageclass = "";
//   bool isloading = false;
//   final ImagePicker _picker = ImagePicker();
//   Color prime = primaryColor;
//   Color current = primaryColor;
// //
// //
//   Future showmodalloading() async {
//     AlertDialog alert = AlertDialog(
//       backgroundColor: colorWhite,
//       content: SizedBox(
//         height: 65,
//         width: 50,
//         child: Column(
//           children: const [
//             CircularProgressIndicator(
//               color: primaryColor,
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               "processing image",
//             )
//           ],
//         ),
//       ),
//     );
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return alert;
//         });
//     await Future.delayed(const Duration(milliseconds: 5000));
//     setState(() {
//       Navigator.pop(context);
//       imageClassification();
//     });
//   }

// //
//   //hanlde pick imagefrom gallery
//   handlepickphotoGallery() async {
//     XFile? imagepath =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
//     setState(() {
//       imagepathfile = imagepath;
//     });

//     if (imagepathfile != null) {
//       showmodalloading();
//     }
//   }

//   //load the tflite model from folder assets
//   Future loadModel() async {
//     Tflite.close();
//     await Tflite.loadModel(
//       model: 'assets/model_unquant.tflite',
//       labels: 'assets/labels.txt',
//       isAsset: true,
//       useGpuDelegate: false,
//     );
//   }

//   //color image detection function
//   Future imageClassification() async {
//     var imgClassification = await Tflite.runModelOnImage(
//         path: imagepathfile!.path,
//         numResults: 14,
//         threshold: 0.03,
//         imageMean: 127.5,
//         imageStd: 127.5,
//         asynch: true);
//     setState(() {
//       _result = imgClassification!;
//     });
//   }

//   //return image pixel
//   Widget hanldeimagepixelColor(BuildContext context) {
//     if (isloading = true) {
//       Image img = Image.file(File(imagepathfile!.path));
//       return ImagePixels(
//           imageProvider: img.image,
//           builder: (context, img) {
//             try {
//               int? imgwidth = img.width;
//               int? imghieght = img.height;
//               double helfwidth = imgwidth! / 2;
//               double halfhieght = imghieght! / 2;
//               double helfwidth2 = imgwidth / 3;
//               double halfhieght2 = imghieght / 2;
//               int xRelative = helfwidth.toInt();
//               int yRelative = halfhieght.toInt();
//               int xRelative2 = helfwidth2.toInt();
//               int yRelative2 = halfhieght2.toInt();
//               Color color = img.pixelColorAt!(xRelative, yRelative);
//               Color color2 = img.pixelColorAt!(xRelative2, yRelative2);
//               var colorhex = "${color.value}";
//               var colorhex2 = "${color2.value}";
//               var colorhexvalue = "#${color.value.toRadixString(16)}";
//               var colorhexvalue2 = "#${color2.value.toRadixString(16)}";
//               return Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           itemcolorValue = colorhex;
//                           widget.itemcolorcon.text = colorhexvalue.toString();
//                           squarecolor = color;
//                         });
//                       },
//                       child: Container(
//                         height: 45,
//                         width: 50,
//                         decoration:
//                             BoxDecoration(shape: BoxShape.circle, color: color),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           itemcolorValue = colorhex2;
//                           widget.itemcolorcon.text = colorhexvalue2.toString();
//                           squarecolor = color2;
//                         });
//                       },
//                       child: Container(
//                         height: 45,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle, color: color2),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } catch (error) {
//               debugPrint("$error");
//             }
//             return Container();
//           });
//     } else {
//       return Container();
//     }
//   }

//   //BuildColorpicker
//   Widget buildcolorpicker() => ColorPicker(
//       pickerColor: current,
//       enableAlpha: false,
//       labelTypes: const [],
//       onColorChanged: (color) => setState(() {
//             squarecolor = color;
//             widget.itemcolorcon.text = "#${color.value.toRadixString(16)}";
//             itemcolorValue = color.value.toString();
//           }));
//   //pickedcolor
//   pickedColor(BuildContext context) => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             content: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   buildcolorpicker(),
//                   TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("SELECT")),
//                 ],
//               ),
//             ),
//           ));
//   //==
//   @override
//   void initState() {
//     loadModel();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final widthsize = MediaQuery.of(context).size.width;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           children: [
//             Container(
//               width: widthsize,
//               height: 230.0,
//               color: seconprimaryColor,
//               child: imagepathfile == null
//                   ? const Center(
//                       child: Text("no image selected"),
//                     )
//                   : Image.file(
//                       File(imagepathfile!.path),
//                       fit: BoxFit.cover,
//                     ),
//             ),
//             Positioned(
//                 top: 160.0,
//                 right: 15.0,
//                 child: GestureDetector(
//                   onTap: () {
//                     checkpermission();
//                     setState(() {
//                       isloading = true;
//                     });
//                   },
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: const BoxDecoration(
//                         shape: BoxShape.circle, color: primaryColor),
//                     child: const Icon(
//                       Icons.camera_outlined,
//                       color: colorWhite,
//                     ),
//                   ),
//                 )),
//             Positioned(
//                 bottom: 20.0,
//                 right: 80.0,
//                 child: GestureDetector(
//                   onTap: () {
//                     handlepickphotoGallery();
//                     setState(() {
//                       isloading = true;
//                     });
//                   },
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: const BoxDecoration(
//                         shape: BoxShape.circle, color: primaryColor),
//                     child: const Icon(
//                       Icons.filter,
//                       color: colorWhite,
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 18.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                   width: widthsize * 0.89,
//                   child: TextFormField(
//                     controller: widget.itemtitlecon,
//                     keyboardType: TextInputType.name,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.description_outlined,
//                         color: primaryColor,
//                       ),
//                       labelText: 'Item name ',
//                       labelStyle:
//                           GoogleFonts.inter(fontSize: 12, color: colorgrey),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(0)),
//                     ),
//                   )),
//               const SizedBox(
//                 height: 10,
//               ),
//               imagepathfile == null
//                   ? Container()
//                   : const TextViewPoppins(
//                       title: "Suggested item name",
//                       fontsize: 14,
//                       fontcolor: colorblack),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: imagepathfile == null
//                     ? Container()
//                     : Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: (isloading = true)
//                             ? _result.map((result) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     imageclass = "${result['label']}";
//                                     widget.itemtitlecon.text = imageclass;
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(12.0),
//                                     child: Container(
//                                         height: 35,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(30),
//                                             color: primaryColor),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             "${result['label']}",
//                                             style: const TextStyle(
//                                                 color: colorWhite),
//                                           ),
//                                         )),
//                                   ),
//                                 );
//                               }).toList()
//                             : [],
//                       ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: TextFormField(
//                       readOnly: true,
//                       controller: widget.itemcolorcon,
//                       keyboardType: TextInputType.name,
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(
//                           Icons.color_lens_outlined,
//                           color: primaryColor,
//                         ),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             pickedColor(context);
//                           },
//                           icon: Icon(
//                             Icons.square,
//                             color: squarecolor,
//                           ),
//                         ),
//                         labelText: 'Color ',
//                         labelStyle:
//                             GoogleFonts.inter(fontSize: 12, color: colorgrey),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(0)),
//                       ),
//                     ),
//                   ),
//                   const Expanded(flex: 1, child: ItemTypeCategory())
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               imagepathfile == null
//                   ? Container()
//                   : const TextViewPoppins(
//                       title: "Suggested colors",
//                       fontsize: 14,
//                       fontcolor: colorblack),
//               imagepathfile == null
//                   ? Container()
//                   : hanldeimagepixelColor(context),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void checkpermission() async {
//     var cameraper = await Permission.camera.status;
//     if (!cameraper.isGranted) {
//       await Permission.camera.request();
//     } else if (cameraper.isDenied) {
//       await Permission.camera.request();
//     } else {
//       handelcamera();
//     }
//   }

//   void handelcamera() async {
//     final XFile? cameraselect =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 60);

//     setState(() {
//       imagepathfile = cameraselect;
//     });
//     if (imagepathfile != null) {
//       showmodalloading();
//     }
//   }
// }