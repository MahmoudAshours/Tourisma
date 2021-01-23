import 'package:flutter/material.dart';
import 'package:places_recommendation/places_recommendation.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlacesRecommendation(),
    );
  }
}
