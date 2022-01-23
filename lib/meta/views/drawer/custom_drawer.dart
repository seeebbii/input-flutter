import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/app/constants/controller.constant.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/root.page_controller.notifier.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  @override
  void initState() {
    super.initState();
  }
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  children:  [
                    SizedBox(
                      height: 0.02.sh.sm,
                    ),
                    ListTile(
                      onTap: (){
                        navigationController.goBack();
                        context.read<RootPageNotifier>().animateToIndex(0);
                      },
                      dense: true,
                      title: Text("Session", style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 14.sm),),
                      leading: Icon(Icons.close, size: 20.sm,),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}