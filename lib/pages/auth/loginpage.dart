import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/color.dart';
import 'package:social_app/components/textfeild.dart';
import 'package:social_app/pages/auth/signuppage.dart';
import 'package:social_app/services/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwCon = TextEditingController();
  signIn() async {
    try {
      String response = await AuthMethods().signIn(
          email: emailCon.text, password: passwCon.text, context: context);
      if (response == 'Success') {
        print('Success');
      } else {
        print('Failed');
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Failed'),
        backgroundColor: Colors.red,
      ));
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
                    /*SizedBox(
                      height: 10,
                    ),*/
                    Gap(20),
                    Image.asset(
                      'assets/Logo1.png',
                      height: 210,
                    ),
                    Gap(10),
                    Text(
                      'JiT App',
                      style: TextStyle(
                          fontSize: 30, fontFamily: 'Dosis', color: pinkColor),
                    ),
                    Gap(70),
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
                              signIn();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text('Login',
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
                          "Don't have an account?",
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
                                    builder: (context) => SignupPage(),
                                  ),
                                  (route) => false);
                            },
                            child: Text(
                              'Register now',
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
