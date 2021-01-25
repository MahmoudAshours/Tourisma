import 'package:flutter/material.dart';
import 'package:places_recommendation/Provider/AuthBloc/signin_bloc.dart';
import 'package:places_recommendation/Provider/AuthBloc/signup_bloc.dart';
import 'package:places_recommendation/Provider/RatingBloc/rating_bloc.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final MaterialApp child;
  Providers({this.child});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInBloc()),
        ChangeNotifierProvider(create: (_) => SignUpBloc()),
        ChangeNotifierProvider(create: (_) => PlacesBloc()),

        // ChangeNotifierProxyProvider2<SignUpBloc, SignInBloc, ActivityBloc>(
        //   create: (_) => ActivityBloc(),
        //   update: (_, signUp, signIn, activity) {
        //     if (signIn.getUserUID == null) {
        //       return activity..userUID = signUp.userUID;
        //     } else if (signUp.userUID == null) {
        //       return activity..userUID = signIn.getUserUID;
        //     } else {
        //       return activity..userUID = signIn.getUserUID;
        //     }
        //   },
        // ),
      ],
      child: child,
    );
  }
}
