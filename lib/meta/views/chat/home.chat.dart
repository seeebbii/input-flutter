import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/core/notifiers/root.page_controller.notifier.dart';
import 'package:input_flutter/meta/utils/app_theme.dart';
import 'package:input_flutter/meta/views/chat/widgets/mobile/mobile_chat_widget.dart';
import 'package:input_flutter/meta/views/chat/widgets/web/web_chat_widget.dart';
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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      builder: () => Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if(constraints.maxWidth < 800){
                  // return mobile widget
                  return const MobileChatWidget();
                }else{
                  // return web widget
                  return const WebChatWidget();
                }
              },
            )
          ),
          Container(
            height: 0.05.sh,
            decoration: const BoxDecoration(
              color: AppTheme.errorColor
            ),
          )
        ],
      ),
    );
  }
}
