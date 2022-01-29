import 'package:covine/login.dart';
import 'package:covine/nearby_interface.dart';
import 'package:covine/registration.dart';
import 'package:covine/screen3.dart';
import 'package:covine/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      theme: ThemeData(fontFamily: 'Exo'),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        NearbyInterface.id: (context) =>
            NearbyInterface(ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
