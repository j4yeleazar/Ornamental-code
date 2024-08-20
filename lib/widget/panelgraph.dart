import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Panelgraph extends StatelessWidget {
  final String lifespan;
  final String spread;
  final String growth;
  final double percent;
  const Panelgraph({
    super.key,
    required this.widthsize,
    required this.lifespan,
    required this.spread,
    required this.growth,
    required this.percent,
  });

  final double widthsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: widthsize * 0.90,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26, // Shadow color
              offset: Offset(0, 4), // Offset of the shadow
              blurRadius: 10, // Blur radius of the shadow
              spreadRadius: 1, // Spread radius of the shadow
            ),
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Life Span",
                          style:
                              TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.local_florist_outlined,
                              color: Color(0xff9EB5F6),
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                lifespan.isNotEmpty
                                    ? Text(
                                        lifespan,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    : const LoadingAnimation(),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  " Days",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 27),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Spread",
                          style:
                              TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Color(0xffFC729B),
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                spread.isNotEmpty
                                    ? Text(
                                        spread,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    : const LoadingAnimation(),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "LvL",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: growth.isNotEmpty
                ? CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 15.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: percent,
                    backgroundWidth: 9,
                    backgroundColor: const Color.fromARGB(22, 0, 0, 0),
                    center: Text(
                      "$growth\n Growth",
                      textAlign: TextAlign.center,
                    ),
                    progressColor: Colors.green,
                  )
                : const LoadingAnimation(),
          )
        ],
      ),
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          LoadingAnimationWidget.prograssiveDots(color: Colors.green, size: 35),
    );
  }
}
