import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PlacesRecommendation extends StatefulWidget {
  @override
  _PlacesRecommendationState createState() => _PlacesRecommendationState();
}

class _PlacesRecommendationState extends State<PlacesRecommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  pickFile() async {
    final input = new File().openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();

    print(fields);
  }
}

assetToFile({String assetPath}) async {
  Directory directory = await getApplicationDocumentsDirectory();

  var path = join(directory.path, assetPath.split('/')[2]);
  ByteData data = await rootBundle.load(assetPath);
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var file = await File(path).writeAsBytes(bytes);
  return file.path;
}
