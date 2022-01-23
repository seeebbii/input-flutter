import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/app/constants/assets.constant.dart';
import 'package:input_flutter/app/constants/controller.constant.dart';
import '../../../core/router/router_generator.dart';
import '../../utils/app_theme.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({Key? key}) : super(key: key);

  @override
  _MainSplashState createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> with SingleTickerProviderStateMixin{

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
    // REMOVING SPLASH SCREEN
    Future.delayed(const Duration(seconds: 2), ()=> navigationController.getOffAll(RouteGenerator.authDecider));
  }


  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      builder: () => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.chatBg), fit: BoxFit.cover, filterQuality: FilterQuality.low,
              ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  renderImage ? SizedBox(
                    height: 0.5.sh,
                    child: Image.asset(
                        Assets.appLogo,
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.cover,
                      ),
                  ) : const SizedBox.shrink(),
                  SizedBox(
                    height: 0.15.sp,
                  ),
                  renderText ? DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 9.0,
                      fontFamily: 'Consolas',
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText('C:\\User\\Root>input --init', textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: defaultTargetPlatform == TargetPlatform.android ? 15.sm : 18.sm),
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
