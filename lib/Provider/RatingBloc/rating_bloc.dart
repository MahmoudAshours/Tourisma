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

  Stream<QuerySnapshot> getUserPlaces({userID}) {
    return FirebaseFirestore.instance
        .collection('UserPlaces')
        .doc(userID)
        .collection('Places')
        .snapshots();
  }
}
