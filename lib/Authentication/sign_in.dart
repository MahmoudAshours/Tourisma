import 'package:flutter/material.dart';
import 'package:places_recommendation/Components/SignInComponents/email_component.dart';
import 'package:places_recommendation/Components/SignInComponents/new_user.dart';
import 'package:places_recommendation/Components/SignInComponents/password_component.dart';
import 'package:places_recommendation/Components/SignInComponents/signinbutton_component.dart'; 

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: EmailComponent(),
              ),
              SizedBox(height: 40),
              PasswordComponent(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                    alignment: Alignment.bottomRight, child: SignInButton()),
              ),
              NewUser()
            ],
          ),
        ),
      ),
    );
  }
}
