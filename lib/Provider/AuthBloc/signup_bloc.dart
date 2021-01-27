import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places_recommendation/Provider/AuthBloc/validators.dart';
import 'package:places_recommendation/Screens/places_recommendation.dart';
import 'package:places_recommendation/Services/auth_service.dart';

class SignUpBloc with ChangeNotifier {
  String email;
  String password;
  String confirmPassword;
  bool validateEmail = true;
  bool validatePassword = true;
  bool validateConfirmPassword = true;
  final _authService = AuthService();
  final _validator = Validators();
  var _userUID;

  get userUID => _userUID;

  populate(context, uid) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/places.json");
    final jsonResult = json.decode(data);
    for (var i in jsonResult) {
      FirebaseFirestore.instance
          .collection('UserPlaces')
          .doc(uid)
          .collection("Places")
          .doc(i['Name'])
          .set({
        "ID": 1,
        "PlaceID": i['id'],
        "Latitude": i['Latitude'],
        "Longitude": i['Longitude'],
        "Image": i['Image'],
        "hasLake": (i['hasLake']),
        "isRestaurant": (i['isRestaurant']),
        "isShopping": (i['isShopping']),
        "Rate": i["Rate"],
        "Name": i['Name']
      });
    }
    return null;
  }

  void signUp(BuildContext context) {
    if (!_validator.validateEmailMessage(email)) {
      validateEmail = false;
      notifyListeners();
    } else if (!_validator.validatePasswordMessage(password)) {
      validatePassword = false;
      notifyListeners();
    } else if (password != confirmPassword) {
      validateConfirmPassword = false;
      notifyListeners();
    } else {
      validateEmail = true;
      validatePassword = true;
      validateConfirmPassword = true;
      notifyListeners();
      _authService.signUp('$email', '$password', context).then(
        (String uid) {
          if (uid != null) {
            _userUID = uid;
            populate(context, uid);
            notifyListeners();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PlacesRecommendation(uid: uid,)));
          }
        },
      );
    }
  }
}
