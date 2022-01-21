import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:input_flutter/core/controllers/navigation/navigation_controller.dart';
import 'package:input_flutter/core/notifiers/platform.notifier.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'core/router/router_generator.dart';
import 'meta/utils/app_theme.dart';
import 'meta/utils/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationController());
  await SharedPref.init();

  runApp(const InputMain());
}

class InputMain extends StatefulWidget {
  const InputMain({Key? key}) : super(key: key);

  @override
  _InputMainState createState() => _InputMainState();
}

class _InputMainState extends State<InputMain> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlatformNotifier(),)
      ],
      child: ScreenUtilInit(
          builder: () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget!),
                maxWidth: 1920,
                minWidth: 1080,
                defaultScale: true,
                breakpoints: const [
                  ResponsiveBreakpoint.resize(450, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
            ),
            initialRoute: RouteGenerator.mainSplashScreen,
            onGenerateRoute: RouteGenerator.onGeneratedRoutes,
          )),
    );
  }
}


