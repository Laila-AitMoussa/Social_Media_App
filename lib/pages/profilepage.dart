import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/components/post_profile.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/editpage.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/authentication.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  List<String> images = [
    "assets/women.jpg",
    "assets/man.jpg",
  ];
  logOut() async {
    try {
      String res = await AuthMethods().signOut();
      if (res == 'Logout') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Logout'),
          backgroundColor: Colors.red,
        ));

        Navigator.of(context).pushReplacementNamed('/welcome');
      }

      /* */
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userModel.username,
          style: TextStyle(
              color: pinkColor,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white.withOpacity(0.3),
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: Icon(Icons.logout_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                userModel.pic == ""
                    ? CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        backgroundImage: AssetImage('assets/person3.jpg'),
                      )
                    : CircleAvatar(
                        radius: 43,
                        backgroundImage: NetworkImage(userModel.pic)),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: grisColor.withOpacity(0.05)),
                  child: Column(
                    children: [
                      ImageStack(
                        backgroundColor: Colors.white.withOpacity(0.3),

                        imageBorderColor: Colors.white.withOpacity(0.3),
                        imageSource: ImageSource.Asset,
                        imageList: images,
                        totalCount: images
                            .length, // If larger than images.length, will show extra empty circle
                        imageRadius: 35, // Radius of each images
                        // Maximum number of images to be shown in stack
                        imageBorderWidth: 2.5, // Border width around the images
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Text(
                            userModel.followers.length.toString(),
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
                        backgroundColor: Colors.white.withOpacity(0.3),
                        extraCountBorderColor: pinkColor.withOpacity(0.4),
                        extraCountTextStyle: TextStyle(
                            color: pinkColor,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold),
                        imageBorderColor: Colors.white.withOpacity(0.3),
                        imageSource: ImageSource.Asset,
                        imageList: images,
                        totalCount: images
                            .length, // If larger than images.length, will show extra empty circle
                        imageRadius: 35, // Radius of each images
                        imageCount:
                            2, // Maximum number of images to be shown in stack
                        imageBorderWidth: 2.5, // Border width around the images
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Text(
                            userModel.following.length.toString(),
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
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                userModel.name,
                style: TextStyle(
                    color: pinkColor,
                    fontSize: 17,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '@${userModel.username}',
                style: TextStyle(
                    fontSize: 15,
                    color: grisColor.withOpacity(0.6),
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Gap(5),
            userModel.bio == ""
                ? Container()
                : Row(
                    children: [
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  color: pinkColor.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(13)),
                              child: Center(
                                  child: Text(
                                userModel.bio,
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
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      Provider.of<UserProvider>(context, listen: false)
                          .getDetails();
                    },
                    child: GridView.builder(
                      itemCount: snapshot
                          .data!.docs.length, //snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        dynamic item = snapshot.data!.docs[index];
                        return Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item['postImage']), //
                                  fit: BoxFit.cover),
                              color: grisColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                        );
                      },
                    ),
                  );
                },
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
