import 'package:flutter/material.dart';
import 'package:input_flutter/meta/views/splash/main.splash.dart';

// ignore: todo
// TODO : ROUTES GENERATOR CLASS THAT CONTROLS THE FLOW OF NAVIGATION/ROUTING


class RouteGenerator {


  // SPLASH / ON BOARDING
  static const String mainSplashScreen = '/main-splash-screen';

  // HOME
  // const String placeholder = '/placeholder';

  //Profile
  static const String personalInfo='/personal-info';

  // Drawer
  static const String customDrawer='/custom-drawer';


  // FUNCTION THAT HANDLES ROUTING
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {

    late dynamic args;
    if (settings.arguments != null) {
      args = settings.arguments as Map;
    }
    debugPrint(settings.name);
    switch (settings.name) {

      case mainSplashScreen:
        return _getPageRoute(const MainSplash());

    // case customDrawer:
    //   return _getPageRoute(const CustomDrawer());

      default:
        return _errorRoute();
    }
  }

  // FUNCTION THAT HANDLES NAVIGATION
  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (ctx) => child);
  }

  // 404 PAGE
  static PageRoute _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('ERROR 404: Not Found'),
        ),
      );
    });
  }
}