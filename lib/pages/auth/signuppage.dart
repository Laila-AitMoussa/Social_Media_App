// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/color.dart';
import 'package:social_app/components/textfeild.dart';
import 'package:social_app/pages/auth/loginpage.dart';
import 'package:social_app/pages/statesignup/errorpage.dart';
import 'package:social_app/pages/statesignup/successpage.dart';
import 'package:social_app/services/authentication.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController usernameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwCon = TextEditingController();
  register() async {
    try {
      String response = await AuthMethods().signUp(
          name: nameCon.text,
          username: usernameCon.text,
          email: emailCon.text,
          password: passwCon.text);
      if (response == 'Success') {
        print('Success');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SuccessPage(),
        ));
      } else {
        print('Failed');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ErrorPage(),
        ));
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/Logo1.png',
                      height: 170,
                    ),
                    Gap(10),
                    Text(
                      'JiT App',
                      style: TextStyle(
                          fontSize: 27, fontFamily: 'Dosis', color: pinkColor),
                    ),
                    Gap(40),
                    InputText(
                      text: 'Name',
                      icon: Icons.person,
                      isHiden: false,
                      controller: nameCon,
                    ),
                    Gap(20),
                    InputText(
                      text: 'Username',
                      icon: Icons.alternate_email,
                      isHiden: false,
                      controller: usernameCon,
                    ),
                    Gap(20),
                    InputText(
                      text: 'Email',
                      icon: Icons.email,
                      isHiden: false,
                      controller: emailCon,
                    ),
                    Gap(20),
                    InputText(
                      text: 'Password',
                      icon: Icons.password,
                      isHiden: true,
                      controller: passwCon,
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: pinkColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                            ),
                            onPressed: () {
                              register();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text('Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                              color: grisColor,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                  (route) => false);
                            },
                            child: Text(
                              'Login Now',
                              style: TextStyle(
                                  color: pinkColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
