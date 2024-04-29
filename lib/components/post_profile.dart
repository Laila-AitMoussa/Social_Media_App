import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/commentpage.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';
import 'package:transparent_image/transparent_image.dart';

class PostProfile extends StatefulWidget {
  dynamic item;
  PostProfile({required this.item, super.key});

  @override
  State<PostProfile> createState() => _PostProfileState();
}

class _PostProfileState extends State<PostProfile> {
  int commentCount = 0;
  Future loadImage() async {
    try {
      // load network image example
      await precacheImage(NetworkImage(widget.item['postImage']), context);
      print('Image loaded and cached successfully!');
    } catch (e) {
      print('Failed to load and cache the image: $e');
    }
  }

  getCommentCount() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.item['postId'])
          .collection('comments')
          .get();
      if (mounted) {
        setState(() {
          commentCount = snap.docs.length;
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCommentCount();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    getCommentCount();
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: grisColor.withOpacity(0.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  DateFormat('d/M/y H:m')
                      .format(widget.item['date'].toDate())
                      .toString(),
                  style: TextStyle(
                    color: grisColor,
                    fontSize: 13,
                  )),
            ],
          ),
          Gap(7),
          Center(
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.item['postImage'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Gap(5),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.item['description'],
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          Gap(3),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    CloudMethods().likePost(widget.item['postId'],
                        userModel.uid, widget.item['like']);
                  },
                  icon: widget.item['like'].contains(userModel.uid)
                      ? Icon(
                          Icons.favorite_rounded,
                          color: pinkColor,
                          size: 20,
                        )
                      : Icon(
                          Icons.favorite_border_rounded,
                          size: 20,
                        )),
              // Gap(2),
              Text(widget.item['like'].length.toString()),
              Gap(5),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Commentpage(postId: widget.item['postId']),
                        ));
                  },
                  icon: Icon(
                    Icons.comment,
                    size: 20,
                  )),
              // Gap(2),
              Text(commentCount.toString()),
              Spacer(),
              userModel.uid == widget.item['uid']
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.white.withOpacity(0.9),
                              title: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Alert',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              content: Text(
                                'Are you Sure?',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: pinkColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      //delete here
                                      CloudMethods()
                                          .deletePost(widget.item['postId']);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                          color: pinkColor,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                      ))
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
