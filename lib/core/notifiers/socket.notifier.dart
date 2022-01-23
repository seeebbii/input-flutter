import 'package:flutter/src/widgets/framework.dart';
import 'package:input_flutter/core/notifiers/chat.notifier.dart';
import 'package:input_flutter/meta/utils/shared_pref.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../models/chat.model.dart';

class SocketNotifier extends ChangeNotifier {

  ChatNotifier? _chatNotifier;
  late BuildContext context;
  late IO.Socket socket;
  String mySocketId = "";

  void init(BuildContext ctx) {
    context = ctx;
    notifyListeners();
    connectServer();
  }

  // SocketNotifier(this._chatNotifier) {
  //   if (_chatNotifier != null) {
  //     print("YOU CAN USE CHAT NOTIFIER NOW");
  //     print(_chatNotifier);
  //     // if (_chatNotifier.loggedIn) fetchMessages();
  //   }
  // }


  void emitChatMessage(ChatModel chatModel){
    socket.emit('receive_message', chatModel.toJson());
    notifyListeners();
  } 

  void connectServer() {
    socket = IO.io('https://input-server.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket', ],
      'autoConnect': false,
    }).connect();

    // TODO :: MY EVENTS

    socket.on('connection', (val) {
      String? name = SharedPref().pref.getString('name');
      String? userId = SharedPref().pref.getString('user-id');
      mySocketId = val['Socket-Id'];
      socket.emit('socket-connection-success', {"socketId" : mySocketId,"connectionStatus": "Connected", "userName": name, "userId": userId, });
      notifyListeners();
    });

    socket.on('disconnect', (val) {

    });

    socket.on('send_message', (chatModelObject) {
      ChatModel newChatMessage = ChatModel.fromJson(chatModelObject);
      print(newChatMessage);
      context.read<ChatNotifier>().addNewMessage(newChatMessage);
    });


    // TODO :: SOCKET CORE EVENTS

    socket.onConnect((val) {
      debugPrint('Socket connected');
    });

    socket.onReconnect(
            (_) => debugPrint("Socket Couldn't connect reconnecting to"));

    socket.onReconnectAttempt(
          (_) {
        debugPrint("Socket Couldn't connect reconnect attempting");
      },
    );

    socket.onReconnectFailed(
          (error) {
        debugPrint('Socket Socket reconnect failed due to $error');
      },
    );

    socket.onConnecting((_) => debugPrint('Socket Connecting'));

    socket.onError((error) {
      debugPrint('Socket error $error');
    });

    socket.onDisconnect((_) {
      debugPrint('Socket disconnected');
    });
  }

  void disconnectServer() {
    String? name = SharedPref().pref.getString('name');
    String? userId = SharedPref().pref.getString('user-id');
    socket.emit('socket-disconnected', {"socketId" : mySocketId,"connectionStatus": "Disconnected", "userName": name, "userId": userId, });
    socket.disconnect();
    notifyListeners();
  }
}
