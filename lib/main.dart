import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:places_recommendation/Authentication/sign_in.dart';
import 'package:places_recommendation/Provider/AuthBloc/signin_bloc.dart';
import 'package:places_recommendation/Screens/places_recommendation.dart';
import 'package:places_recommendation/Themes/themes.dart';
import 'package:places_recommendation/intro_page.dart';
import 'package:places_recommendation/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    Providers(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: await checkIntro()
            ? IntroPage()
            : Consumer<SignInBloc>(
                builder: (_, bloc, __) {
                  return StreamBuilder<User>(
                    stream: bloc.checkAuth(),
                    builder: (_, AsyncSnapshot<User> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return PlacesRecommendation(
                            bloc: bloc, uid: snapshot.data.uid);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return SignIn();
                      }
                    },
                  );
                },
              ),
        theme: themes,
      ),
    ),
  );
}

Future<bool> checkIntro() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('intro') ?? true;
}
