import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    pickFile(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: pickFile(context),
          builder: (d, sna) => Container(
            child: Center(
              child: Swiper(
                itemBuilder: (d, s) => Container(
                  child: Text('${sna.data[s]['Name']}'),
                ),
                itemCount: sna.data.length,
                autoplay: true,
                fade: 0.9,
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickFile(context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/places.json");
    final jsonResult = json.decode(data);
    return jsonResult;
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
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
}
