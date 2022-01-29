import 'package:covine/components/rounded_button.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'registration.dart';

import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 48.0,
          ),
          RoundedButton(
            title: 'Log In',
            colour: Colors.deepPurple[400],
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 500),
                  child: LoginScreen(),
                ),
              );
            },
          ),
          RoundedButton(
            title: 'Register',
            colour: Colors.deepPurpleAccent,
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 500),
                  child: RegistrationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
