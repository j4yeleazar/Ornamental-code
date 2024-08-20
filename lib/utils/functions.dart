import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ornamental/widget/desccard.dart';
import 'package:ornamental/widget/panelgraph.dart';

Widget plantdescriptions(String type) {
  if (type == 'Santan') {
    return const Descriptioncard(
      tittle: "Santan",
      description:
          "Ixora coccinea is a species of flowering plant in the family Rubiaceae. It is a common flowering shrub",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    );
  } else if (type == 'Lantana') {
    return const Descriptioncard(
      tittle: "Lantana",
      description:
          "Lantana is a genus of about 150 species of perennial flowering plants in the verbena family, Verbenaceae.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    );
  } else if (type == 'Pandakaki') {
    return const Descriptioncard(
      tittle: "Pandakaki",
      description:
          "Tabernaemontana pandacaqui, known as windmill bush and banana bush, is a species of plant in the dogbane family",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    );
  } else if (type == 'Butterfly Pea') {
    return const Descriptioncard(
      tittle: "Butterfly Pea",
      description:
          "Butterfly Pea is a plant species belonging to the family Fabaceae, endemic and native to the Indonesian island",
      planttype: "Herbal",
      icontype: Icon(
        Icons.filter_vintage_outlined,
        color: Colors.green,
      ),
    );
  } else if (type == 'Yellow Bell') {
    return const Descriptioncard(
      tittle: "Yellow Bell",
      description:
          "Yellow Bell or Tecoma stans is a fast-growing evergreen shrub with slender, gray-brown branches and clusters of bright yellow, trumpet-shaped flowers.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    );
  } else if (type == 'Acalypha') {
    return const Descriptioncard(
      tittle: "Acalypha",
      description:
          "Acalypha wilkesiana, common names copperleaf, Jacob's coat and Flamengueira, is an evergreen shrub growing to 3 metres (9.8 ft) high and 2 metres (6 ft 7 in) across.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    );
  } else if (type == 'Picara') {
    return const Descriptioncard(
      tittle: "Picara",
      description:
          "Chinese croton, also known as Picarra is a Chinese and Japanese native plant. It's a low-growing shrub with arching stems and variegated pale green leaves that are off-white on top and brilliant lacquer red beneath.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    );
  } else if (type == 'CannaLily') {
    return const Descriptioncard(
      tittle: "CannaLily",
      description:
          "Canna indica is a long-lived (perennial) herbaceous plant, 90-180 cm tall. The upright (erect) stems (1-2 m tall) are sturdy, hairless (glabrous) and green in colour.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    );
  } else {
    return Container();
  }
}

Widget panelGraph(String type, double widthsize) {
  if (type == 'Santan') {
    return Panelgraph(
        percent: 0.50,
        widthsize: widthsize,
        lifespan: "234",
        spread: "123",
        growth: "245mm");
  } else if (type == 'Lantana') {
    return Panelgraph(
        percent: 0.30,
        widthsize: widthsize,
        lifespan: "134",
        spread: "523",
        growth: "145mm");
  } else if (type == 'Pandakaki') {
    return Panelgraph(
        percent: 0.60,
        widthsize: widthsize,
        lifespan: "334",
        spread: "623",
        growth: "745mm");
  } else if (type == 'Butterfly Pea') {
    return Panelgraph(
        percent: 0.80,
        widthsize: widthsize,
        lifespan: "834",
        spread: "823",
        growth: "845mm");
  } else if (type == 'Yellow Bell') {
    return Panelgraph(
        percent: 0.60,
        widthsize: widthsize,
        lifespan: "3650",
        spread: "1014",
        growth: "600mm");
  } else if (type == 'Acalypha') {
    return Panelgraph(
        percent: 0.40,
        widthsize: widthsize,
        lifespan: "1095",
        spread: "914",
        growth: "500mm");
  } else if (type == 'Picara') {
    return Panelgraph(
        percent: 0.30,
        widthsize: widthsize,
        lifespan: "1825",
        spread: "524",
        growth: "240");
  } else if (type == 'CannaLily') {
    return Panelgraph(
        percent: 0.50,
        widthsize: widthsize,
        lifespan: "1095",
        spread: "460",
        growth: "560");
  } else {
    return const LoadingAnimation();
  }
}

int generateTwoDigitRandomNumber() {
  final random = Random();
  return 10 + random.nextInt(90);
}

String generateRandomLetters(int length) {
  const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => letters.codeUnitAt(random.nextInt(letters.length)),
    ),
  );
}
