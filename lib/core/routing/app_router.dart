import 'package:flutter/material.dart';
import 'package:my_resturant_dashboard/core/routing/routes.dart';
import 'package:my_resturant_dashboard/Features/Login/View/login_screen.dart';
import 'package:my_resturant_dashboard/Features/Root/root.dart';
import 'package:my_resturant_dashboard/Features/Home/ui/home_screen.dart';
import 'package:my_resturant_dashboard/Features/My_Resturant/view/my_restu_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          builder: (_) => Root(),
        );
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => DashboardHomeScreen(),
        );
      case Routes.myresturantpage:
        return MaterialPageRoute(
          builder: (_) => MyResturantMainScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
