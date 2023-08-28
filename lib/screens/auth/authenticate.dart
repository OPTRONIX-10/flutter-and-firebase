import 'package:firebase_and_flutter/screens/auth/signIn.dart';
import 'package:firebase_and_flutter/screens/auth/signUp.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn = true;

  void _toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSignIn) {
      return SignIn(
        toggleView: _toggleView,
      );
    } else {
      return SignUp(
        toggleView: _toggleView,
      );
    }
  }
}
