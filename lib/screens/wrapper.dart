import 'package:firebase_and_flutter/models/userModel.dart';
import 'package:firebase_and_flutter/screens/auth/authenticate.dart';
import 'package:firebase_and_flutter/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
