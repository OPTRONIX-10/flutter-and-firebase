import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_and_flutter/models/brewsModel.dart';
import 'package:firebase_and_flutter/models/userModel.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({required this.uid});

  // collecction referece
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(
      {required String sugars,
      required String name,
      required int strength}) async {
    await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //brew list from snapshot

  List<BrewsModel> _brewListfromSnapshot({required QuerySnapshot snapshot}) {
    return snapshot.docs.map((doc) {
      return BrewsModel(
          sugars: doc.get('sugars') ?? '',
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }

  //get brews Stream

  Stream<List<BrewsModel>> get brews {
    return brewCollection.snapshots().map(
        (QuerySnapshot snapshot) => _brewListfromSnapshot(snapshot: snapshot));
  }

  //get user doc from userSnapshot

  UserDataModel _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserDataModel(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

  // get user doc stream

  Stream<UserDataModel> get userData {
    return brewCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) => _userDatafromSnapshot(snapshot));
  }
}
