import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const MyElevatedButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 11.sm,
                color: Colors.white54,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
        ),
      ),
    );
  }
}
