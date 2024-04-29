import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/color.dart';
import 'package:social_app/components/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.3),
          surfaceTintColor: Colors.white,
          title: Text(
            'JiT App',
            style: TextStyle(
                fontFamily: 'Dance',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: pinkColor),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message,
                  color: grisColor,
                ))
          ],
        ),
        body: StreamBuilder(
            stream: posts.orderBy('date', descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('something went wrong..'),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: pinkColor,
                ));
              }

              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  dynamic data = snapshot.data! as dynamic;
                  dynamic item = data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PostCard(
                      item: item,
                    ),
                  );
                },
              );
            }));
  }
}
