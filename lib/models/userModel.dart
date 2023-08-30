class UserModel {
  final String id;

  UserModel({required this.id});
}

class UserDataModel {
  final String? uid;
  final String name;
  final String sugars;
  final int strength;

  UserDataModel(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
