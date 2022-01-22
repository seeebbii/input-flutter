import 'package:flutter/material.dart';
import 'package:input_flutter/meta/views/auth/code.auth.dart';
import 'package:input_flutter/meta/views/auth/decider.auth.dart';
import 'package:input_flutter/meta/views/splash/main.splash.dart';

// ignore: todo
// TODO : ROUTES GENERATOR CLASS THAT CONTROLS THE FLOW OF NAVIGATION/ROUTING

class RouteGenerator {
  // SPLASH / ON BOARDING
  static const String mainSplashScreen = '/main-splash-screen';

  // AUTH
  static const String authDecider = '/auth-decider';
  static const String codeAuth = '/code-auth';

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

      case authDecider:
        return _getPageRoute(const AuthDecider());

      case codeAuth:
        return _getPageRoute(const CodeAuth());

      // case customDrawer:
      //   return _getPageRoute(const CustomDrawer());

      default:
        return _errorRoute();
    }
  }

  // FUNCTION THAT HANDLES NAVIGATION
  static PageRoute _getPageRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    );
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
