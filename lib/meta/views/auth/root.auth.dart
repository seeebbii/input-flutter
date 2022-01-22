import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/meta/views/auth/code.auth.dart';
import 'package:input_flutter/meta/views/chat/home.chat.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/assets.constant.dart';
import '../../../components/dialogs/custom_snackbars.dart';
import '../../../core/notifiers/auth.notifier.dart';
import '../../../core/notifiers/connectivity.notifier.dart';
import '../../../core/notifiers/root.page_controller.notifier.dart';
import '../../utils/app_theme.dart';

class RootAuth extends StatefulWidget {
  bool isSessionAvailable;
  String? id = '';

  RootAuth({Key? key, required this.isSessionAvailable, this.id})
      : super(key: key);

  @override
  _RootAuthState createState() => _RootAuthState();
}

class _RootAuthState extends State<RootAuth>
    with AutomaticKeepAliveClientMixin<RootAuth> {
  String _timeString = '';

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      getUserDetails(widget.id!);
    });
  }

  void getUserDetails(String id) {
    if (widget.isSessionAvailable) {
      context.read<AuthNotifier>().renewSession(id).then((value) async {
        if (value) {
          String? name = await context.read<AuthNotifier>().getUserName();
          context.read<RootPageNotifier>().animateToIndex(1);
          CustomSnackBar.openIconSnackBar(
              context, "Session restored </$name>", const Icon(Icons.done));
        } else {
          if (context.read<ConnectionNotifier>().isOnline) {
            CustomSnackBar.openErrorSnackBar(
              context,
              "Spyder may have been deleted",
            );
          } else {
            CustomSnackBar.openErrorSnackBar(
              context,
              "No Internet Connection",
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1.sh.sm),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Consumer<AuthNotifier>(
            builder: (BuildContext context, authNotifier, Widget? child) {
              return authNotifier.currentSpyder.userId != null &&
                      authNotifier.currentSpyder.userId != ""
                  ? Tooltip(
                      message: "Destroy Session",
                      child: IconButton(
                          onPressed: () {
                            authNotifier.destroyUserState();
                            context.read<RootPageNotifier>().animateToIndex(0);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ),
      ),
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
              bottom: 12,
              child: Text(
                "NB Studios - Copyright \u00a9 2022 . All Rights Reserved",
                softWrap: true,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontFamily: "Consolas"),
              )),
          Positioned(
              bottom: 12,
              right: 3.sp,
              child: size.width < 800
                  ? const SizedBox.shrink()
                  : Consumer<RootPageNotifier>(
                      builder: (BuildContext context, rootPageNotifier, Widget? child) {
                        return Text(
                          _timeString,
                          style: TextStyle(
                              fontSize: 12,
                              color: rootPageNotifier.currentPageIndex == 0 ? Colors.black : Colors.white,
                              letterSpacing: 1,
                              fontFamily: "Consolas"),
                        );
                      },
                    )),
        ],
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
