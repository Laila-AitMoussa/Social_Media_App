import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 52, 40),
              Color.fromARGB(255, 216, 21, 7).withOpacity(0.1)
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
                  Icons.error_outlined,
                  color: Colors.white,
                  size: 170,
                ),
                Gap(15),
                Text(
                  'Oh Noo',
                  style: TextStyle(
                      fontSize: 27,
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Gap(5),
                Text(
                  'Something went wrong, please try again',
                  style: TextStyle(
                      fontSize: 17, fontFamily: 'Raleway', color: Colors.white),
                ),
                Gap(25),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_circle_left_rounded,
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
