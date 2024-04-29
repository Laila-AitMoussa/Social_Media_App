import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String username;
  String email;
  String bio;
  String pic;
  List followers;
  List following;
  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.bio,
    required this.pic,
    required this.followers,
    required this.following,
    required this.email,
  });
  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: snapshot['uid'],
        email: snapshot['email'],
        name: snapshot['name'],
        username: snapshot['username'],
        bio: snapshot['bio'],
        pic: snapshot['pic'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'username': username,
        'bio': bio,
        'pic': pic,
        'followers': followers,
        'following': following,
      };
}
