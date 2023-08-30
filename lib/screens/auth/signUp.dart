import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../../shared/loading.dart';
import '../services/authService.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({required this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService _auth = AuthService();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text(
                'SignUp',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
              actions: [
                TextButton.icon(
                    onPressed: () async {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label:
                        Text('SignIn', style: TextStyle(color: Colors.white)))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _email,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Empty Field'
                                : null,
                            decoration: decoration.copyWith(hintText: 'Email')),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: _password,
                            obscureText: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Empty Field'
                                : null,
                            decoration:
                                decoration.copyWith(hintText: 'Password')),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _loading = true);
                              final result = await _auth.registerEmailPass(
                                  email: _email.text, password: _password.text);
                              if (result == null) {
                                setState(() => _loading = false);
                              }
                            }
                          },
                          child: Text('SignUp'),
                        )
                      ],
                    ))),
          );
  }
}
