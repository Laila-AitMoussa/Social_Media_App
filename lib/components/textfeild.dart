import 'package:flutter/material.dart';
import 'package:social_app/color.dart';

class InputText extends StatefulWidget {
  String text;
  IconData icon;
  bool isHiden;
  TextEditingController controller;
  InputText(
      {required this.text,
      required this.icon,
      super.key,
      required this.isHiden,
      required this.controller});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText: widget.isHiden,
      controller: widget.controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(
              color: grisColor.withOpacity(0.6),
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
          prefixIcon: Icon(widget.icon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: pinkColor.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: pinkColor),
              borderRadius: BorderRadius.circular(15))),
    );
  }
}
