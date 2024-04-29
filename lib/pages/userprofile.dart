import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/components/post_profile.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';

class UserProfile extends StatefulWidget {
  dynamic item;

  UserProfile({required this.item, super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with TickerProviderStateMixin {
  bool isFollowing = false;
  bool isLoad = true;
  int following = 0;
  int followers = 0;
  List<String> images = [
    "assets/women.jpg",
    "assets/man.jpg",
  ];
  late TabController _tabController = TabController(length: 2, vsync: this);
  getUserData() async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.item['uid'])
          .get();
      isFollowing = (userData.data() as dynamic)['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      followers = (userData.data()! as dynamic)['followers'].length;
      following = (userData.data()! as dynamic)['following'].length;
      setState(() {
        isLoad = false;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return isLoad
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white.withOpacity(0.3),
              surfaceTintColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      widget.item['pic'] == ""
                          ? CircleAvatar(
                              radius: 43,
                              backgroundColor: Colors.white.withOpacity(0.5),
                              backgroundImage: AssetImage('assets/person3.jpg'),
                            )
                          : CircleAvatar(
                              radius: 43,
                              backgroundImage:
                                  NetworkImage(widget.item['pic'])),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: grisColor.withOpacity(0.05)),
                        child: Column(
                          children: [
                            ImageStack(
                              showTotalCount: false,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              imageBorderColor: Colors.white.withOpacity(0.3),
                              imageSource: ImageSource.Asset,
                              imageList: images,
                              totalCount: images
                                  .length, // If larger than images.length, will show extra empty circle
                              imageRadius: 35, // Radius of each images
                              imageCount:
                                  2, // Maximum number of images to be shown in stack
                              imageBorderWidth:
                                  2.5, // Border width around the images
                            ),
                            Gap(10),
                            Row(
                              children: [
                                Text(
                                  followers.toString(),
                                  style: TextStyle(
                                      color: grisColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                                Gap(5),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                      color: grisColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: grisColor.withOpacity(0.05)),
                        child: Column(
                          children: [
                            ImageStack(
                              showTotalCount: false,
                              backgroundColor: Colors.white.withOpacity(0.3),

                              imageBorderColor: Colors.white.withOpacity(0.3),
                              imageSource: ImageSource.Asset,
                              imageList: images,
                              totalCount: images
                                  .length, // If larger than images.length, will show extra empty circle
                              imageRadius: 35, // Radius of each images
                              imageCount:
                                  2, // Maximum number of images to be shown in stack
                              imageBorderWidth:
                                  2.5, // Border width around the images
                            ),
                            Gap(10),
                            Row(
                              children: [
                                Text(
                                  following.toString(),
                                  style: TextStyle(
                                      color: grisColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                                Gap(5),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                      color: grisColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            widget.item['name'],
                            style: TextStyle(
                                color: pinkColor,
                                fontSize: 17,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '@${widget.item['username']}',
                            style: TextStyle(
                                color: grisColor.withOpacity(0.6),
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      userModel.uid == widget.item['uid']
                          ? Container()
                          : Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await CloudMethods().followUser(
                                        userModel.uid, widget.item['uid']);
                                    setState(() {
                                      isFollowing ? followers-- : followers++;
                                      isFollowing = !isFollowing;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: pinkColor,
                                      foregroundColor: Colors.white),
                                  child: Row(
                                    children: [
                                      Text(
                                        isFollowing ? 'Unfollow' : 'Follow',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      isFollowing
                                          ? Icon(Icons.remove)
                                          : Icon(Icons.add),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      padding: EdgeInsets.all(10),
                                      side: BorderSide(
                                          color: pinkColor, width: 2),
                                      shape: CircleBorder(),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.white),
                                  child: Icon(
                                    Icons.message,
                                    color: pinkColor,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  Gap(5),
                  widget.item['bio'] == ""
                      ? Container()
                      : Row(
                          children: [
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        color: pinkColor.withOpacity(0.23),
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: Center(
                                        child: Text(
                                      widget.item['bio'],
                                      style: TextStyle(
                                          color: pinkColor,
                                          fontSize: 16,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                    ))))
                          ],
                        ),
                  Gap(10),
                  TabBar(controller: _tabController, tabs: [
                    Tab(
                      text: 'Photos',
                    ),
                    Tab(
                      text: 'Posts',
                    )
                  ]),
                  Gap(8),
                  Expanded(
                      child: TabBarView(controller: _tabController, children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .where('uid', isEqualTo: widget.item['uid'])
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return GridView.builder(
                          itemCount: snapshot.data.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            dynamic item = snapshot.data.docs[index];
                            return Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item['postImage']),
                                      fit: BoxFit.cover),
                                  color: grisColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12)),
                            );
                          },
                        );
                      },
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .where('uid', isEqualTo: widget.item['uid'])
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                            itemCount: snapshot.data.docs.length == 0
                                ? 1
                                : snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              dynamic item = snapshot.data.docs.length == 0
                                  ? ""
                                  : snapshot.data.docs[index];
                              return snapshot.data.docs.length == 0
                                  ? Center(
                                      child: Text('No Posts'),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: PostProfile(
                                        item: item,
                                      ),
                                    );
                            },
                          );
                        }),
                  ]))
                ],
              ),
            ),
          );
  }
}
