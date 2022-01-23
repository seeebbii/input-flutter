import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/components/widgets/my_text_field.dart';
import 'package:input_flutter/core/models/chat.model.dart';
import 'package:input_flutter/core/notifiers/auth.notifier.dart';
import 'package:input_flutter/core/notifiers/chat.notifier.dart';
import 'package:input_flutter/core/notifiers/socket.notifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_theme.dart';

class MobileChatWidget extends StatefulWidget {
  const MobileChatWidget({Key? key}) : super(key: key);

  @override
  _MobileChatWidgetState createState() => _MobileChatWidgetState();
}

class _MobileChatWidgetState extends State<MobileChatWidget> {
  List<ChatModel> chatModel = <ChatModel>[];

  // final scrollController = ScrollController();
  final sendMessageController = TextEditingController();

  Widget _buildSendMessageField() {
    return MyTextField(
      controller: sendMessageController,
      borderRadius: 12,
      containerBoxColor: AppTheme.darkBackgroundColor.withOpacity(0.9),
      hintText: 'Type your message...',
      suffixIcon: const SizedBox.shrink(),
      keyType: TextInputType.text,
      validator: (str) {
        if (str == null || str == '') {
          return "?";
        }
        return null;
      },

      align: TextAlign.start,
      obSecureText: false,
      action: TextInputAction.done,
      onSubmit: (str) {
        sendMessage();
      },
    );
  }


  Widget _buildChatTile(String name, String message, DateTime date){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 8.sm),
      child: ListTile(
        title: Text(message),
        subtitle: Text('</$name>', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppTheme.darkLightColor),),
        contentPadding: EdgeInsets.symmetric(vertical: 5.sm),
        trailing:  Text(DateFormat('dd/yyyy hh:mm').format(date), style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppTheme.darkLightColor, fontSize: 10),),
      ),
    );
  }

  // void _scrollDown() {
  //   scrollController.animateTo(
  //     scrollController.position.maxScrollExtent,
  //     duration: const Duration(seconds: 2),
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }

  void sendMessage(){
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    ChatModel newChat = ChatModel(
        userId: "${authNotifier.currentSpyder.userId}",
        name: "${authNotifier.currentSpyder.name}",
        messageId: "",
        sentDate: DateTime.now(),
        message: sendMessageController.text.trim());

    context.read<SocketNotifier>().emitChatMessage(newChat);
    sendMessageController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ChatNotifier>(builder: (BuildContext context, chatNotifier , Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                controller: chatNotifier.chatScrollController,
                  itemCount: chatNotifier.myChatList.length,
                  itemBuilder: (ctx, index) {
                    ChatModel obj =chatNotifier.myChatList[index];
                    return _buildChatTile(obj.name!, obj.message!, obj.sentDate!);
                  }),
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 5.sm,),
                  Expanded(child: _buildSendMessageField()),
                  OutlinedButton(onPressed: sendMessage , child: Icon(Icons.send, color: AppTheme.darkLightColor, size: 20.sm,),
                    style: OutlinedButton.styleFrom(
                        shadowColor: Colors.transparent
                    ),)
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}

