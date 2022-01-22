import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/meta/views/auth/code.auth.dart';
import 'package:input_flutter/meta/views/chat/home.chat.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/assets.constant.dart';
import '../../../components/dialogs/custom_snackbars.dart';
import '../../../core/notifiers/auth.notifier.dart';
import '../../../core/notifiers/root.page_controller.notifier.dart';
import '../../utils/app_theme.dart';

class RootAuth extends StatefulWidget {
  bool? isSessionAvailable = false;
  String? id = '';
  RootAuth({Key? key, this.isSessionAvailable, this.id}) : super(key: key);

  @override
  _RootAuthState createState() => _RootAuthState();
}

class _RootAuthState extends State<RootAuth> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      getUserDetails(widget.id!);
    });
  }

  void getUserDetails(String id) {
    context.read<AuthNotifier>().renewSession(id).then((value) async {
      if(value){
        String? name = await context.read<AuthNotifier>().getUserName();
        context.read<RootPageNotifier>().animateToIndex(1);
        CustomSnackBar.openIconSnackBar(context, "Session restored </$name>", const Icon(Icons.done));
      }else{
        CustomSnackBar.openErrorSnackBar(context, "No Internet Connection",);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.chatBg),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Consumer<RootPageNotifier>(
                builder:
                    (BuildContext context, rootPageNotifier, Widget? child) {
                  return PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: rootPageNotifier.pageViewController,
                    onPageChanged: rootPageNotifier.updatePageIndex,
                    children: const [CodeAuth(), HomeChat()],
                  );
                },
              ),
            ),
          ),
          const Positioned(
              bottom: 10,
              child: Text(
                "NB Studios - Copyright \u00a9 2022 . All Rights Reserved",
                style: TextStyle(
                    fontSize: 12, color: Colors.white, letterSpacing: 1, fontFamily: "Consolas"),
              ))
        ],
      ),
    );
  }
}
