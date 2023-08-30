import 'package:firebase_and_flutter/models/userModel.dart';
import 'package:firebase_and_flutter/screens/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // custom user based on firebase user
  UserModel? _userFromFirebaseUser({required User? user}) {
    return user != null ? UserModel(id: user.uid) : null;
  }

  // auth change user stream

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(
          (User? user) => _userFromFirebaseUser(user: user),
        );
  }
  //sign in anon

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user: user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with eamil and passsword

  Future signInEmailpass({required String email, required password}) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return _userFromFirebaseUser(user: user);
  }

  // register with email and password

  Future registerEmailPass(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create user document in fireStrore with uid

      DatabaseService(uid: user!.uid)
          .updateUserData(sugars: '0', name: 'Welcome Member', strength: 100);
      return _userFromFirebaseUser(user: user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
