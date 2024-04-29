import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/color.dart';
import 'package:social_app/pages/userprofile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.3),
        surfaceTintColor: Colors.white,
        title: Text(
          'Search Users',
          style: TextStyle(
              color: pinkColor,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
        ),
      ),
      //backgroundColor: grisLightColor,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: searchCon,
              onChanged: (value) {
                setState(() {
                  searchCon.text = value;
                });
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 253, 111, 153),
                          width: 1.5)),
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: pinkColor,
                  ),
                  hintText: 'Search by Username',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 13,
                      color: grisColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(color: pinkColor, width: 1.2))),
            ),
            Gap(10),
            Expanded(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where('username', isEqualTo: searchCon.text)
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (searchCon.text != '') {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                          return Text('User not found');
                        }
                      } else {
                        return Container();
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          dynamic item = snapshot.data.docs[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserProfile(
                                  item: item,
                                ),
                              ));
                            },
                            leading: item['pic'] == ""
                                ? CircleAvatar(
                                    radius: 22,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                    backgroundImage:
                                        AssetImage('assets/person3.jpg'),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(item['pic'])),
                            title: Text(
                              item['name'],
                              style: TextStyle(
                                  fontFamily: 'Dosis',
                                  fontSize: 18,
                                  color: pinkDarkColor),
                            ),
                            subtitle: Text(
                              '@${item['username']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: grisColor,
                              ),
                            ),
                          );
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
