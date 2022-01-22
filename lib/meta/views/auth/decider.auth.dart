import 'package:flutter/material.dart';
import 'package:input_flutter/core/notifiers/auth.notifier.dart';
import 'package:input_flutter/meta/views/auth/code.auth.dart';
import 'package:input_flutter/meta/views/auth/root.auth.dart';
import 'package:input_flutter/meta/views/chat/home.chat.dart';
import 'package:provider/provider.dart';

import '../../../components/dialogs/custom_snackbars.dart';

class AuthDecider extends StatefulWidget {
  const AuthDecider({Key? key}) : super(key: key);

  @override
  State<AuthDecider> createState() => _AuthDeciderState();
}

class _AuthDeciderState extends State<AuthDecider> {

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthNotifier>(
      builder: (BuildContext context, authNotifier, Widget? child) {
        return FutureBuilder(
            future: authNotifier.getUserId(),
            builder: (ctx, AsyncSnapshot auth){
              if(auth.hasData && auth.data != null){
                debugPrint("LOGGED IN AS: ${auth.data}");
                return RootAuth(isSessionAvailable: true, id: auth.data,);
              }else{
                return RootAuth(isSessionAvailable: false,);
              }
            });
      },
    );

  }

  @override
  void initState() {
    super.initState();
  }
}