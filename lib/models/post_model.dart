import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String uid;
  String name;
  String username;
  String pic;
  String description;
  String postId;
  String postImage;
  Timestamp date;
  dynamic like;
  PostModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.date,
    required this.pic,
    required this.description,
    required this.like,
    required this.postId,
    required this.postImage,
  });
  factory PostModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      username: snapshot['username'],
      date: snapshot['date'],
      pic: snapshot['pic'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      like: snapshot['like'],
      postImage: snapshot['postImage'],
    );
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'username': username,
        'date': date,
        'pic': pic,
        'description': description,
        'postId': postId,
        'postImage': postImage,
        'like': like,
      };
}
