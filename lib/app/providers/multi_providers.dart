
import 'package:flutter/material.dart';
import 'package:input_flutter/core/models/chat.model.dart';
import 'package:input_flutter/core/notifiers/active_users.notifier.dart';
import 'package:input_flutter/core/notifiers/auth.notifier.dart';
import 'package:input_flutter/core/notifiers/chat.notifier.dart';
import 'package:provider/provider.dart';

import '../../core/notifiers/connectivity.notifier.dart';
import '../../core/notifiers/root.page_controller.notifier.dart';
import '../../core/notifiers/socket.notifier.dart';

class MultiProviders extends StatelessWidget {
  const MultiProviders(this.child, {Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthNotifier>(
          create: (BuildContext context) => AuthNotifier(),
        ),

        ChangeNotifierProvider<RootPageNotifier>(
          create: (BuildContext context) => RootPageNotifier(),
        ),

        ChangeNotifierProvider<ConnectionNotifier>(
          create: (BuildContext context) => ConnectionNotifier(),
        ),

        ChangeNotifierProvider<SocketNotifier>(
          create: (BuildContext context) => SocketNotifier(),
        ),

        // ChangeNotifierProvider.value(value: SocketNotifier(),),

        ChangeNotifierProvider<ChatNotifier>(
          create: (BuildContext context) => ChatNotifier(),
        ),





        ChangeNotifierProvider<ActiveUsersNotifier>(
          create: (BuildContext context) => ActiveUsersNotifier(),
        ),
      ],
      child: child,
    );
  }
}