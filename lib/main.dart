import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:places_recommendation/Screens/places_recommendation.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlacesRecommendation(),
      theme: ThemeData(fontFamily: 'Noyh'),
    );
  }
}
