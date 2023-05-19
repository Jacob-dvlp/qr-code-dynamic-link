import 'package:flutter/material.dart';
import 'package:qr_code_app/routes/app_route.dart';

import 'home_app.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: RouteServices.generateRoute,
      home: HomeApp(),
    );
  }
}


