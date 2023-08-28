import 'package:firebase_and_flutter/screens/services/authService.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text(
          'SignIn',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text('SignUp', style: TextStyle(color: Colors.white)))
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
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Empty Field' : null,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                        fillColor: Colors.brown[200],
                        filled: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Empty Field' : null,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        fillColor: Colors.brown[200],
                        filled: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final result = await _auth.signInEmailpass(
                            email: _email.text, password: _password.text);
                        if (result == null) {
                          print(null);
                        }
                      } else {
                        return null;
                      }
                    },
                    child: Text('SignIn'),
                  )
                ],
              ))),
    );
  }
}


// ElevatedButton(
//             onPressed: () async {
//               dynamic result = await _auth.signInAnon();
//               if (result == null) {
//                 print('failed');
//               } else {
//                 print('signedIn');
//               }
//             },
//             child: Text('SignIn Anon')),