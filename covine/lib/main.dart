import 'package:covine/constants.dart';
import 'package:covine/screens/login.dart';
import 'package:covine/screens/tracing.dart';
import 'package:covine/screens/registration.dart';
import 'package:covine/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      theme: ThemeData(
        fontFamily: "Montserrat",
        primarySwatch: Colors.blue,
      ),
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
