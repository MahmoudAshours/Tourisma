import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlacesBloc with ChangeNotifier {
  Future<DocumentReference> addUsersRate(context, placeName, rate, uid) async {
    FirebaseFirestore.instance
        .collection('UserPlaces')
        .doc(uid)
        .collection("Places")
        .doc(placeName)
        .update({"Rate": rate});
    return null;
  }

  Future<DocumentReference> addUsersPlaces(context, uid) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/places.json");
    final jsonResult = json.decode(data);
    for (var i in jsonResult) {
      print(i);
      FirebaseFirestore.instance
          .collection('UserPlaces')
          .doc(uid)
          .collection("Places")
          .doc(i['Name'])
          .set({
        "ID": i['id'],
        "Latitude": i['Latitude'],
        "Longitude": i['Longitude'],
        "Image": i['Image'],
        "hasLake": (i['hasLake']),
        "isRestaurant": (i['isRestaurant']),
        "isShopping": (i['isShopping']),
        "Rate": i["Rate"]
      });
    }
    return null;
  }

  Stream<QuerySnapshot> getUserPlaces({userID}) {
    return FirebaseFirestore.instance
        .collection('UserPlaces')
        .doc(userID)
        .collection('Places')
        .snapshots();
  }
}
