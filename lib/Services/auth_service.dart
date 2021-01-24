import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:places_recommendation/Provider/AuthBloc/error_handlerBloc.dart';
import 'package:places_recommendation/Services/base_service.dart'; 

class AuthService implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user.uid;
    } catch (e) {
      final _errHandler = ErrorActions(errorMessages: e.message);
      _errHandler.errorHandler(context);
      return null;
    }
  }

  Future<String> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user.uid;
    } catch (e) {
      final _errHandler = ErrorActions(errorMessages: e.message);
      _errHandler.errorHandler(context);
      return null;
    }
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User user = _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = _firebaseAuth.currentUser;
    return user.emailVerified;
  }

  Stream checkIfLoggedIn() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
