import 'package:flutter/material.dart';
import 'package:social_app/color.dart';
import 'package:social_app/pages/auth/loginpage.dart';
import 'package:social_app/pages/auth/signuppage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 172, 11, 59),
              Color.fromARGB(255, 252, 249, 250)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 65,
              ),
              Image.asset(
                'assets/logo2.png',
                height: 280,
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welecome to ',
                    style: TextStyle(
                        color: pinkLight1Color,
                        fontSize: 28,
                        fontFamily: 'Dance',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' JiT App',
                    style: TextStyle(
                        color: pinkDarkColor,
                        fontSize: 50,
                        fontFamily: 'Dosis',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: pinkColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text('Log In',
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              side: BorderSide(color: pinkColor, width: 2.0)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(13),
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: pinkColor,
                                    fontSize: 18,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold)),
                          ))),
                ],
              ),
              SizedBox(
                height: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
