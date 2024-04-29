import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/pages/auth/loginpage.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 32, 201, 38),
              Color.fromARGB(255, 32, 201, 38).withOpacity(0.1)
            ],
            begin: Alignment.centerRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 170,
                ),
                Gap(15),
                Text(
                  'Congratulations',
                  style: TextStyle(
                      fontSize: 27,
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Gap(5),
                Text(
                  'Your account has been successfully created',
                  style: TextStyle(
                      fontSize: 17, fontFamily: 'Raleway', color: Colors.white),
                ),
                Gap(25),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                    },
                    icon: Icon(
                      Icons.arrow_circle_right,
                      size: 50,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
