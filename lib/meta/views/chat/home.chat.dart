import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/core/notifiers/root.page_controller.notifier.dart';
import 'package:input_flutter/meta/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/socket.notifier.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat>
    with AutomaticKeepAliveClientMixin<HomeChat> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    child: Text("CHAT HOME"),
                    onTap: () {
                      print("Working");
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.05.sh,
            decoration: BoxDecoration(
              color: AppTheme.errorColor
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
