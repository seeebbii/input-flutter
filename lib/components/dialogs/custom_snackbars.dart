import 'package:flutter/material.dart';

class CustomSnackBar{
  static openErrorSnackBar(context, String text ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(milliseconds: 2500),
    ));
  }

  static openIconSnackBar(context, String text, Widget icon) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          icon,
          SizedBox(width: 5,),
          Text(text)
        ],
      ),
      duration: const Duration(milliseconds: 2500),
    ));
  }
}