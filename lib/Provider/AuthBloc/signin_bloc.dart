import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:places_recommendation/Screens/places_recommendation.dart';
import 'package:places_recommendation/Services/auth_service.dart'; 
class SignInBloc with ChangeNotifier {
  String email;
  String password;
  final _authService = AuthService();
  var _userUID;

  set userUID(uid) {
    _userUID = uid; 
  }

  get getUserUID => _userUID;

  void signIn(BuildContext context) {
    _authService.signIn('$email', '$password', context).then(
      (String uid) {
        if (uid != null) {
          _userUID = uid;
          notifyListeners();
          routePush(PlacesRecommendation(), RouterType.fade);
          notifyListeners();
        }
      },
    );
  }

  void signOut(BuildContext context) => _authService.signOut();

  Stream checkAuth() => _authService.checkIfLoggedIn();
}
