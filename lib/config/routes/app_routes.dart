import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobize_app/features/post_result/presentation/pages/home_screen.dart';
import '../../features/get_ leaderboard/presentation/pages/result_screen.dart';
import '../../features/sing_up/presentation/pages/sing_up_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String storeDataRoute = '/store';
  static const String resultRoute = '/result';
}

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    Widget buildHomeScreen() {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return const SingUpScreen();
            } else {
              return HomeScreen(
                name: FirebaseAuth.instance.currentUser!.displayName,
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => buildHomeScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/profile':
        return MaterialPageRoute(builder: (context) => const ResultScreen());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('No Route Found'),
        ),
      ),
    );
  }
}
