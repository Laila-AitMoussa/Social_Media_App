import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/utils/picker.dart';

class AddPage extends StatefulWidget {
  final VoidCallback? onNextPage;
  const AddPage({super.key, this.onNextPage});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Uint8List? file;
  bool isLoad = false;
  TextEditingController descCon = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  uploadPost() async {
    try {
      UserModel user =
          Provider.of<UserProvider>(context, listen: false).userModel!;
      setState(() {
        isLoad = true;
      });
      String res = await CloudMethods().uploadPost(
          pic: user.pic,
          uid: user.uid,
          name: user.name,
          username: user.username,
          description: descCon.text,
          file: file!);
      print(res);
      if (res == 'Success') {
        setState(() {
          isLoad = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Post Added'),
          backgroundColor: Colors.green,
        ));
        if (widget.onNextPage != null) {
          widget.onNextPage!();
        }
        descCon.clear();
        setState(() {
          file = null;
        });
      } else {
        setState(() {
          isLoad = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add Post'),
          backgroundColor: Colors.red,
        ));
        print('Failed');
      }
    } catch (e) {
      setState(() {
        isLoad = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user =
        Provider.of<UserProvider>(context, listen: false).userModel!;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.3),
        surfaceTintColor: Colors.white,
        title: Text(
          'Add Post',
          style: TextStyle(
              color: pinkColor,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                uploadPost();
              },
              icon: Icon(
                Icons.near_me_outlined,
                color: grisColor,
              ))
        ],
      ),
      //backgroundColor: grisLightColor,
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(color: pinkColor),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user.pic == ""
                          ? CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.5),
                              backgroundImage: AssetImage('assets/person3.jpg'),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(user.pic)),
                      Gap(14),
                      Expanded(
                        child: TextField(
                          controller: descCon,
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: 'Type here ...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: file == null
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                      image: MemoryImage(file!),
                                      fit: BoxFit.fill)),
                            )),
                  Gap(40),
                  IconButton(
                    onPressed: () async {
                      _key.currentState!.showBottomSheet(
                        (context) => Container(
                          padding: EdgeInsets.fromLTRB(13, 0, 13, 13),
                          height: 185,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            border: Border(
                                top: BorderSide(width: 4, color: pinkColor)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Icon(
                                Icons.horizontal_rule,
                                size: 35,
                                color: pinkColor,
                              )),
                              Text(
                                'Post Image',
                                style: TextStyle(
                                    color: grisColor,
                                    fontSize: 19,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              Gap(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                          style: IconButton.styleFrom(
                                              padding: EdgeInsets.all(10),
                                              shape: CircleBorder(),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: grisColor
                                                      .withOpacity(0.2))),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            Uint8List? myFile =
                                                await pickImage2();
                                            setState(() {
                                              file = myFile;
                                            });
                                          },
                                          icon: Icon(
                                            size: 30,
                                            Icons.camera_alt_outlined,
                                            color: pinkColor,
                                          )),
                                      Gap(10),
                                      Text(
                                        'Camera',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: grisColor,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Gap(30),
                                  Column(
                                    children: [
                                      IconButton(
                                          style: IconButton.styleFrom(
                                              padding: EdgeInsets.all(10),
                                              shape: CircleBorder(),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: grisColor
                                                      .withOpacity(0.2))),
                                          onPressed: () async {
                                            Navigator.pop(context);
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
                                            fontWeight: FontWeight.bold),
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
                    icon: Icon(
                      Icons.camera,
                      color: grisLightColor,
                      size: 25,
                    ),
                    style: IconButton.styleFrom(
                        backgroundColor: pinkColor,
                        padding: EdgeInsets.all(15)),
                  ),
                  Gap(25)
                ],
              ),
            ),
    );
  }
}
