import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ornamental/widget/desccard.dart';
import 'package:ornamental/widget/panelgraph.dart';
import 'package:ornamental/widget/carecard.dart';

Widget plantdescriptions(String type) {
  final descriptions = {
    'Santan': const Descriptioncard(
      tittle: "Santan",
      description:
          "Ixora coccinea is a species of flowering plant in the family Rubiaceae. It is a common flowering shrub",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    ),
    'Lantana': const Descriptioncard(
      tittle: "Lantana",
      description:
          "Lantana is a genus of about 150 species of perennial flowering plants in the verbena family, Verbenaceae.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    ),
    'Pandakaki': const Descriptioncard(
      tittle: "Pandakaki",
      description:
          "Tabernaemontana pandacaqui, known as windmill bush and banana bush, is a species of plant in the dogbane family",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    ),
    'Butterfly Pea': const Descriptioncard(
      tittle: "Butterfly Pea",
      description:
          "Butterfly Pea is a plant species belonging to the family Fabaceae, endemic and native to the Indonesian island",
      planttype: "Herbal",
      icontype: Icon(
        Icons.filter_vintage_outlined,
        color: Colors.green,
      ),
    ),
    'Yellow Bell': const Descriptioncard(
      tittle: "Yellow Bell",
      description:
          "Yellow Bell or Tecoma stans is a fast-growing evergreen shrub with slender, gray-brown branches and clusters of bright yellow, trumpet-shaped flowers.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    ),
    'Acalypha': const Descriptioncard(
      tittle: "Acalypha",
      description:
          "Acalypha wilkesiana, common names copperleaf, Jacob's coat and Flamengueira, is an evergreen shrub growing to 3 metres (9.8 ft) high and 2 metres (6 ft 7 in) across.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    ),
    'Picara': const Descriptioncard(
      tittle: "Picara",
      description:
          "Chinese croton, also known as Picarra is a Chinese and Japanese native plant. It's a low-growing shrub with arching stems and variegated pale green leaves that are off-white on top and brilliant lacquer red beneath.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    ),
    'CannaLily': const Descriptioncard(
      tittle: "CannaLily",
      description:
          "Canna indica is a long-lived (perennial) herbaceous plant, 90-180 cm tall. The upright (erect) stems (1-2 m tall) are sturdy, hairless (glabrous) and green in colour.",
      planttype: "Shrub",
      icontype: Icon(
        Icons.spa_outlined,
        color: Colors.green,
      ),
    ),
  };

  return descriptions[type] ?? Container();
}

Widget panelGraph(String type, double widthsize) {
  final panelData = {
    'Santan': Panelgraph(
      percent: 0.50,
      widthsize: widthsize,
      lifespan: "234",
      spread: "123",
      growth: "245mm",
    ),
    'Lantana': Panelgraph(
      percent: 0.30,
      widthsize: widthsize,
      lifespan: "134",
      spread: "523",
      growth: "145mm",
    ),
    'Pandakaki': Panelgraph(
      percent: 0.60,
      widthsize: widthsize,
      lifespan: "334",
      spread: "623",
      growth: "745mm",
    ),
    'Butterfly Pea': Panelgraph(
      percent: 0.80,
      widthsize: widthsize,
      lifespan: "834",
      spread: "823",
      growth: "845mm",
    ),
    'Yellow Bell': Panelgraph(
      percent: 0.60,
      widthsize: widthsize,
      lifespan: "3650",
      spread: "1014",
      growth: "600mm",
    ),
    'Acalypha': Panelgraph(
      percent: 0.40,
      widthsize: widthsize,
      lifespan: "1095",
      spread: "914",
      growth: "500mm",
    ),
    'Picara': Panelgraph(
      percent: 0.30,
      widthsize: widthsize,
      lifespan: "1825",
      spread: "524",
      growth: "240",
    ),
    'CannaLily': Panelgraph(
      percent: 0.50,
      widthsize: widthsize,
      lifespan: "1095",
      spread: "460",
      growth: "560",
    ),
  };

  return panelData[type] ?? const LoadingAnimation();
}

Widget plantCare(String type) {
  final caredescriptions = {
    'Santan': const Carecard(
      titlee: "Santan Care",
      caredesc:
          "Water regularly, especially during dry seasons, and ensure the soil remains moist but not soggy. Plant in well-drained garden soil in a sunny location to encourage vibrant blooms.",
      icontype: Icon(Icons.sunny, color: Colors.orange),
    ),
    'Lantana': const Carecard(
      titlee: "Lantana Care",
      caredesc:
          "Prune regularly to control its spread and promote fresh blooms. Lantana thrives in partial to full sunlight and is best grown in garden beds or large outdoor pots with well-draining soil.",
      icontype: Icon(Icons.grass, color: Colors.green),
    ),
    'Pandakaki': const Carecard(
      titlee: "Pandakaki Care",
      caredesc:
          "Avoid overwatering and keep the soil slightly moist. Pandakaki is suitable for shaded areas and performs well in pots or garden soil with good drainage.",
      icontype: Icon(Icons.water_drop, color: Colors.blue),
    ),
    'Butterfly Pea': const Carecard(
      titlee: "Butterfly Pea Care",
      caredesc:
          "Provide ample sunlight and ensure the plant has support for climbing, such as trellises or fences. Best planted in garden soil with adequate drainage.",
      icontype: Icon(Icons.park, color: Colors.brown),
    ),
    'Yellow Bell': const Carecard(
      titlee: "Yellow Bell Care",
      caredesc:
          "Water moderately and place in areas with full sunlight. Yellow Bell grows best in well-drained soil and is ideal for garden beds or larger pots outdoors.",
      icontype: Icon(Icons.sunny, color: Colors.yellow),
    ),
    'Acalypha': const Carecard(
      titlee: "Acalypha Care",
      caredesc:
          "Maintain high humidity levels and place the plant in a location with bright but indirect light. Acalypha is well-suited for decorative pots indoors or shaded outdoor areas with moist soil.",
      icontype: Icon(Icons.spa, color: Colors.red),
    ),
    'Picara': const Carecard(
      titlee: "Picara Care",
      caredesc:
          "Prune regularly to maintain its shape, and ensure the soil is moist but not waterlogged. Picara thrives in garden beds with rich soil or pots for indoor decoration.",
      icontype: Icon(Icons.nature, color: Colors.green),
    ),
    'CannaLily': const Carecard(
      titlee: "Canna Lily Care",
      caredesc:
          "Prefers rich, fertile soil and full sunlight. Water frequently to keep the soil moist. Best suited for garden beds but can also grow in large pots with proper care.",
      icontype: Icon(Icons.eco, color: Colors.orange),
    ),
  };

  // Default card in case the plant type is not found
  return caredescriptions[type] ??
      const Carecard(
        titlee: "Unknown Plant",
        caredesc: "Care instructions are unavailable for this plant.",
        icontype: Icon(Icons.help_outline, color: Colors.grey),
      );
}

int generateTwoDigitRandomNumber() {
  return 10 + Random().nextInt(90);
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
