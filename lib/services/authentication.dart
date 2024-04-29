import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layoutpage.dart';
import 'package:social_app/models/user_model.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot = await users.doc(currentUser.uid).get();
    return UserModel.fromSnap(documentSnapshot);
  }

  signUp({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    String res = 'Error';
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        UserModel userModel = UserModel(
            uid: userCredential.user!.uid,
            name: name,
            username: username,
            bio: '',
            pic: '',
            followers: [],
            following: [],
            email: email);
        users.doc(userCredential.user!.uid).set(userModel.toJson());
        return res = 'Success';
      } else {
        return res = 'Enter all fields';
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String res = 'Error';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Success'),
          backgroundColor: Colors.green,
        ));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LayoutPage(),
            ),
            (route) => false);
        return res = 'Success';
      } else {
        return res = 'Enter all fields';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Failed'),
        backgroundColor: Colors.red,
      ));
      return res = e.toString();
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
      return 'Logout';
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
