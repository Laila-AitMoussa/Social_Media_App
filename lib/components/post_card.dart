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

class PostCard extends StatefulWidget {
  /* String name;
  String username;
  Timestamp date;
  String postImage;
  String pic;
  String description;
  String postId;
  dynamic like;
  String uid;*/
  dynamic item;
  PostCard(
      {/*required this.name,
      required this.username,
      required this.date,
      required this.postImage,
      required this.description,
      required this.pic,
      required this.postId,
      required this.like,
      required this.uid,*/
      required this.item,
      super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentCount = 0;
  bool isLiked = false;
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
      padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: grisColor.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.item['pic'] == ""
                  ? CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      backgroundImage: AssetImage('assets/person3.jpg'),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(widget.item['pic'])),
              Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item['name'],
                    style: TextStyle(
                        fontFamily: 'Dosis',
                        fontSize: 17,
                        color: pinkDarkColor),
                  ),
                  Text(
                    '@${widget.item['username']}',
                    style: TextStyle(
                      fontSize: 15,
                      color: grisColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              //
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
          Gap(15),
          widget.item['postImage'] != ""
              ? Center(
                  child: Container(
                    height: 280,
                    width: 350,
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
                )
              : Container(),
          Gap(10),
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
          Gap(10),
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
                        )
                      : Icon(Icons.favorite_border_rounded)),
              Gap(5),
              Text(widget.item['like'].length.toString()),
              Gap(10),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Commentpage(postId: widget.item['postId']),
                        ));
                  },
                  icon: Icon(Icons.comment)),
              Gap(5),
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
                      icon: Icon(Icons.delete))
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
