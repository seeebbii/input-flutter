import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/core/notifiers/auth.notifier.dart';
import 'package:input_flutter/meta/views/chat/widgets/mobile/mobile_chat_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/notifiers/chat.notifier.dart';
import '../../../../utils/app_theme.dart';

class WebChatWidget extends StatefulWidget {
  const WebChatWidget({Key? key}) : super(key: key);

  @override
  _WebChatWidgetState createState() => _WebChatWidgetState();
}

class _WebChatWidgetState extends State<WebChatWidget> {
  final scrollController = ScrollController();

  Widget _buildChatTile(String name, String socketId, int index) {
    bool isMe = context.read<AuthNotifier>().currentSpyder.name == name;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 8.sm),
      child: ListTile(
        leading: Text("$index"),
        title: Text(
          '</$name>',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: isMe ? Colors.green : Colors.white, fontSize: 16.sm),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5.sm),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sm),
      width: 0.8.sw.sm,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Active Users",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 18.sm),
                ),
                Container(
                  height: 0.65.sh.sm,
                  child: Consumer<ChatNotifier>(
                    builder:
                        (BuildContext context, chatNotifier, Widget? child) {
                      return ListView.builder(
                          controller: scrollController,
                          itemCount: chatNotifier.activeUsers.length,
                          itemBuilder: (_, index) {
                            final activeUser = chatNotifier.activeUsers[index];
                            return _buildChatTile(
                                activeUser.name!, activeUser.socketId!, 1);
                          });
                    },
                  ),
                ),
                // Container(
                //   height: 0.6.sh.sm,
                //   child: ListView.builder(itemCount: 500, itemBuilder: (_, index){
                //     return Text("HE");
                //   }),
                // )
              ],
            ),
          )),
          const Expanded(child: MobileChatWidget()),
        ],
      ),
    );
  }
}
