import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../meta/utils/app_theme.dart';

class MyTextField extends StatelessWidget {

  final TextEditingController controller;
  Color containerBoxColor;
  double borderRadius;
  String? hintText;
  Widget? prefix = const SizedBox.shrink();
  bool obSecureText;
  dynamic validator;
  TextInputAction action;
  TextInputType keyType;

  Widget suffixIcon;
  List<TextInputFormatter>? formatter = [];

  AutovalidateMode? validateMode = AutovalidateMode.disabled;

  Function onSubmit;

  MyTextField({Key? key, required this.controller,
    required this.containerBoxColor,
    required this.borderRadius,
    required this.obSecureText,
    required this.validator,
    required this.action,
    required this.keyType,
    required this.suffixIcon,
    this.hintText, this.formatter = const [], this.validateMode = AutovalidateMode.disabled, required this.onSubmit,  this.prefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 3.sm,
          vertical: 3.sm
      ),
      decoration: BoxDecoration(
          color: containerBoxColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: TextFormField(
        onFieldSubmitted:  (str){
          onSubmit(str);
        },
        textAlign: TextAlign.center,
        controller: controller,
        style: Theme
            .of(context)
            .textTheme
            .bodyText1,
        cursorWidth: 1,
        textInputAction: action,
        keyboardType: keyType,
        autovalidateMode: validateMode,
        inputFormatters: formatter,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme
              .of(context)
              .inputDecorationTheme
              .hintStyle,
          suffixIcon: suffixIcon,
          prefix: prefix
        ),
        obscureText: obSecureText,
        cursorColor: AppTheme.errorColor,
        validator: validator,
      ),
    );
  }
}