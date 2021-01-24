import 'package:flutter/material.dart';
import 'package:places_recommendation/Screens/places_recommendation.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlacesRecommendation(),
      theme: ThemeData(fontFamily: 'Noyh'),
    );
  }
}
