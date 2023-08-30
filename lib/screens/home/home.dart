import 'package:firebase_and_flutter/models/brewsModel.dart';
import 'package:firebase_and_flutter/screens/home/settingsForm.dart';
import 'package:firebase_and_flutter/screens/services/authService.dart';
import 'package:firebase_and_flutter/screens/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brewsList.dart';

class Home extends StatelessWidget {
  Home({super.key});

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<BrewsModel>>.value(
      value: DatabaseService(uid: null).brews,
      initialData: [],
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showSettingsPanel(),
          label: Icon(Icons.settings),
          backgroundColor: Colors.brown[400],
        ),
        backgroundColor: Colors.brown[70],
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.brown[400],
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text('LogOut', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee_bg.png'),
                    fit: BoxFit.fill)),
            child: BrewsList()),
      ),
    );
  }
}
