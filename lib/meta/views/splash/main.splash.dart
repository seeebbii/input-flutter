import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/app/constants/assets.constant.dart';
import 'package:input_flutter/core/notifiers/platform.notifier.dart';
import 'package:provider/provider.dart';

import '../../utils/app_theme.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({Key? key}) : super(key: key);

  @override
  _MainSplashState createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {

  bool renderImage = false;
  bool renderText = false;

  void toggleTextBool(){
    setState(() {
      renderText = true;
    });
  }

  void toggleImageBool(){
    setState(() {
      renderImage = true;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), toggleImageBool);
    Future.delayed(const Duration(milliseconds: 1200), toggleTextBool);
  }


  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      builder: () => Scaffold(
        backgroundColor: AppTheme.darkBackgroundColor,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.chatBg), fit: BoxFit.cover, filterQuality: FilterQuality.low,
              ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  renderImage ? SizedBox(
                      height: 0.5.sh,
                      child: Image.asset(
                        Assets.appLogo,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      )) : const SizedBox.shrink(),
                  SizedBox(
                    height: 0.15.sp,
                  ),
                  renderText ? DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 9.0,
                      fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText('C:\\User\\Root>input --init', textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: defaultTargetPlatform == TargetPlatform.android ? 15 : 18),
                            speed: const Duration(milliseconds: 300), curve: Curves.decelerate, ),
                      ],
                    ),
                  ) : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
