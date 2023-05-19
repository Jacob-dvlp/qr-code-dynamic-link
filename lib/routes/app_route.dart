
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_app.dart';
import '../product.dart';

class RouteServices {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/homepage':
        return CupertinoPageRoute(builder: (_) {
          return const HomeApp();
        });

      case "/productpage":
        if (args is Map) {
          return CupertinoPageRoute(builder: (_) {
            return ProductPage(
              productId: args["productId"],
            );
          });
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Page Not Found"),
        ),
      );
    });
  }
}
