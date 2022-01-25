import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:input_flutter/core/models/chat.model.dart';
import 'package:input_flutter/core/notifiers/socket.notifier.dart';

import '../models/active_users.model.dart';

class ChatNotifier extends ChangeNotifier {
  List<ChatModel> myChatList = <ChatModel>[];
  List<ActiveUsersModel> activeUsers = <ActiveUsersModel>[];
  ScrollController chatScrollController = ScrollController();

  void addActiveUser(ActiveUsersModel activeUser) {
    var existingItem = activeUsers.firstWhere(
        (itemToCheck) => itemToCheck.name == activeUser.name,
        orElse: () => ActiveUsersModel());
    print("CHAT ADD ACTIVE USER : ${existingItem.name}");
    if (existingItem.name == null ) {
      print('NEW USER ADDED');
      activeUsers.add(activeUser);
      notifyListeners();
    }
  }

  void removeActiveUser(String activeUser) {
    activeUsers.removeWhere((element) => element.socketId == activeUser);
    notifyListeners();
  }

  void addNewMessage(ChatModel chatModel) {
    myChatList.insert(0, chatModel);
    notifyListeners();
    animateToEnd();
  }

  void addPreviousChatMessages(List<ChatModel> oldChatList) {
    myChatList = oldChatList;
    notifyListeners();
  }

  void animateToEnd() {
    chatScrollController.animateTo(0.0,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 100));
    notifyListeners();
  }
}
