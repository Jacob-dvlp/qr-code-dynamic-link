import 'package:deep_link/init_binding.dart';
import 'package:deep_link/route_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateRoute: RouteServices.generateRoute,
      initialBinding: InitBinding(),
      home: const HomeApp() ,
    );
  }
}
