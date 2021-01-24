import 'package:flutter/material.dart';
import 'package:places_recommendation/Components/SignUpComponents/confirmpass_component.dart';
import 'package:places_recommendation/Components/SignUpComponents/email_signup.dart';
import 'package:places_recommendation/Components/SignUpComponents/password_signup.dart';
import 'package:places_recommendation/Components/SignUpComponents/signupbutton_component.dart';
import 'package:places_recommendation/Components/SignUpComponents/welcome_text.dart';
import 'package:places_recommendation/Provider/AuthBloc/signup_bloc.dart';
import 'package:provider/provider.dart'; 

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Consumer<SignUpBloc>(
          builder: (_, _bloc, __) => Column(
            children: <Widget>[
              JourneyText(),
              SizedBox(height: 60),
              EmailSignUp(),
              SizedBox(height: 30),
              PasswordSignUp(),
              SizedBox(height: 30),
              ConfirmPassword(),
              SizedBox(height: 30),
              SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
