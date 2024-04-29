import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/utils/picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController usernameCon = TextEditingController();
  TextEditingController bioCon = TextEditingController();
  Uint8List? file;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool isLoad = false;
  update(String uid) async {
    try {
      // Store the context before starting the asynchronous operation
      BuildContext? currentContext = context;
      setState(() {
        isLoad = true;
      });
      if (currentContext != null) {
        String res = await CloudMethods().editProfile(
          uid: uid,
          name: nameCon.text,
          username: usernameCon.text,
          file: file,
          bio: bioCon.text,
        );
        // Check if the widget is still mounted before updating the UI
        if (mounted && res == 'Success') {
          Navigator.pop(currentContext);
          setState(() {
            isLoad = false;
          }); // Use the stored context to navigate
        }
      }
    } on Exception catch (e) {
      print(e.toString());
      setState(() {
        isLoad = false;
      });
    }
    Provider.of<UserProvider>(context, listen: false).getDetails();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    nameCon.text = userModel.name;
    usernameCon.text = userModel.username;
    bioCon.text = userModel.bio;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.3),
        surfaceTintColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: pinkColor,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(
                color: pinkColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 20),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: [
                          file == null
                              ? userModel.pic == ""
                                  ? CircleAvatar(
                                      radius: 70,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.5),
                                      backgroundImage:
                                          AssetImage('assets/person3.jpg'),
                                    )
                                  : CircleAvatar(
                                      radius: 70,
                                      backgroundImage:
                                          NetworkImage(userModel.pic))
                              : CircleAvatar(
                                  radius: 70,
                                  backgroundImage: MemoryImage(file!)),
                          Positioned(
                              bottom: -5,
                              right: -5,
                              child: IconButton(
                                  onPressed: () async {
                                    _key.currentState!.showBottomSheet(
                                      (context) => Container(
                                        padding:
                                            EdgeInsets.fromLTRB(13, 0, 13, 13),
                                        height: 185,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          border: Border(
                                              top: BorderSide(
                                                  width: 4, color: pinkColor)),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                                child: Icon(
                                              Icons.horizontal_rule,
                                              size: 35,
                                              color: pinkColor,
                                            )),
                                            Text(
                                              'Profile Image',
                                              style: TextStyle(
                                                  color: grisColor,
                                                  fontSize: 19,
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gap(10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        style: IconButton.styleFrom(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            shape:
                                                                CircleBorder(),
                                                            side: BorderSide(
                                                                width: 1.5,
                                                                color: grisColor
                                                                    .withOpacity(
                                                                        0.2))),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          Uint8List? myFile =
                                                              await pickImage2();
                                                          setState(() {
                                                            file = myFile;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          size: 30,
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: pinkColor,
                                                        )),
                                                    Gap(10),
                                                    Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: grisColor,
                                                          fontFamily: 'Raleway',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                Gap(30),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        style: IconButton.styleFrom(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            shape:
                                                                CircleBorder(),
                                                            side: BorderSide(
                                                                width: 1.5,
                                                                color: grisColor
                                                                    .withOpacity(
                                                                        0.2))),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          Uint8List? myFile =
                                                              await pickImage1();
                                                          setState(() {
                                                            file = myFile;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          size: 30,
                                                          Icons.image_outlined,
                                                          color: pinkColor,
                                                        )),
                                                    Gap(10),
                                                    Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: grisColor,
                                                          fontFamily: 'Raleway',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  style: IconButton.styleFrom(
                                      backgroundColor: pinkColor,
                                      foregroundColor: Colors.white,
                                      shape: CircleBorder()),
                                  icon: Icon(
                                    Icons.edit_square,
                                    size: 20,
                                  )))
                        ],
                      ),
                    ),
                    Gap(40),
                    TextField(
                      controller: nameCon,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: pinkColor.withOpacity(0.09),
                          label: Text(
                            'Name',
                            style: TextStyle(
                                color: pinkColor,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: grisColor.withOpacity(0.7),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    Gap(20),
                    TextField(
                      controller: usernameCon,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: pinkColor.withOpacity(0.09),
                          label: Text(
                            'Username',
                            style: TextStyle(
                                color: pinkColor,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: grisColor.withOpacity(0.7),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    Gap(20),
                    TextField(
                      controller: bioCon,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: pinkColor.withOpacity(0.09),
                          label: Text(
                            'Bio',
                            style: TextStyle(
                                color: pinkColor,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          prefixIcon: Icon(
                            Icons.info_outline,
                            color: grisColor.withOpacity(0.7),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: pinkColor,
                                    elevation: 0.0,
                                    padding: EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                onPressed: () {
                                  update(userModel.uid);
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
