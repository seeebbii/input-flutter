import 'package:input_flutter/meta/utils/shared_pref.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';

class SocketNotifier extends ChangeNotifier {
  late IO.Socket socket;
  String mySocketId = "";

  void init() {
    connectServer();
  }

  void connectServer() {
    socket = IO.io('https://input-server.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket', 'polling' ],
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
      String? name = SharedPref().pref.getString('name');
      String? userId = SharedPref().pref.getString('user-id');
      socket.emit('socket-disconnected', {"socketId" : mySocketId,"connectionStatus": "Disconnected", "userName": name, "userId": userId, });
    });
  }

  void disconnectServer() {
    socket.disconnect();
    notifyListeners();
  }
}
