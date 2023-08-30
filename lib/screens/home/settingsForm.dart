import 'package:firebase_and_flutter/models/userModel.dart';
import 'package:firebase_and_flutter/screens/services/databaseService.dart';
import 'package:firebase_and_flutter/shared/constants.dart';
import 'package:firebase_and_flutter/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName = null;
  String? _currentSugars = null;
  int? _currentStrength = null;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserDataModel>(
      stream: DatabaseService(uid: user.id).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Set your BREW style',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: _currentName ?? userData!.name,
                    decoration: decoration,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter name'
                        : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                      // hint: Text('${userData.sugars} sugars'),
                      value: _currentSugars ?? userData!.sugars,
                      decoration: decoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text('$sugar sugars'),
                          value: sugar,
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => _currentSugars = value)),

                  SizedBox(
                    height: 20,
                  ),
                  //slider
                  Slider(
                      value:
                          (_currentStrength ?? userData!.strength).toDouble(),
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      activeColor:
                          Colors.brown[_currentStrength ?? userData!.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData!.strength],
                      onChanged: (value) =>
                          setState(() => _currentStrength = value.round())),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.id).updateUserData(
                            sugars: _currentSugars ?? userData!.sugars,
                            name: _currentName ?? userData!.name,
                            strength: _currentStrength ?? userData!.strength);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.pink)),
                  )
                ],
              ));
        } else {
          return Loading();
        }
      },
    );
  }
}
