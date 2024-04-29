import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';

class Commentpage extends StatefulWidget {
  final postId;
  const Commentpage({super.key, required this.postId});

  @override
  State<Commentpage> createState() => _CommentpageState();
}

class _CommentpageState extends State<Commentpage> {
  TextEditingController commentCon = TextEditingController();
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  uploadComment(String uid, String name, String pic, String username) async {
    String res = await CloudMethods().commentToPost(
        postId: widget.postId,
        uid: uid,
        comment: commentCon.text,
        pic: pic,
        name: name,
        username: username);
    if (res == 'Success') {
      commentCon.text = '';
    }
  }

  String comment = '';
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: TextStyle(
              color: pinkColor,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white.withOpacity(0.3),
        surfaceTintColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: posts
                        .doc(widget.postId)
                        .collection('comments')
                        .orderBy('date', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('something went wrong..'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          dynamic item = snapshot.data.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: grisColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      item['pic'] == ""
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              backgroundImage: AssetImage(
                                                  'assets/person3.jpg'),
                                            )
                                          : CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(item['pic'])),
                                      Gap(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: TextStyle(
                                                color: pinkColor,
                                                fontSize: 16,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item['username'],
                                            style: TextStyle(
                                                color:
                                                    grisColor.withOpacity(0.8),
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Gap(15),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        item['comment'],
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })),
            Gap(10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentCon,
                    cursorColor: pinkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Type here ...',
                        hintStyle: TextStyle(color: grisColor.withOpacity(0.6)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: pinkColor),
                            borderRadius: BorderRadius.circular(25)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: pinkColor))),
                  ),
                ),
                Gap(5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: pinkColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        shape: CircleBorder()),
                    onPressed: () {
                      uploadComment(userModel.uid, userModel.name,
                          userModel.pic, userModel.username);
                    },
                    child: Icon(Icons.arrow_circle_right_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }
}
