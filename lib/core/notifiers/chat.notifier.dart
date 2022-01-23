import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:input_flutter/core/models/chat.model.dart';
import 'package:input_flutter/core/notifiers/socket.notifier.dart';
class ChatNotifier extends ChangeNotifier{
  List<ChatModel> myChatList = <ChatModel>[];
  ScrollController chatScrollController = ScrollController();



  void addNewMessage(ChatModel chatModel){
    myChatList.insert(0, chatModel);
    notifyListeners();
    animateToEnd();
  }

  void animateToEnd(){
    chatScrollController.animateTo(0.0,curve: Curves.easeOut,duration: const Duration(milliseconds: 100));
    notifyListeners();
  }

}