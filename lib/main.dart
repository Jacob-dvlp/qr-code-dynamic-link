import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/app_widget.dart';

import 'firebase_option.dart';

Future<void> main() async {
  await init();
  runApp(const AppWidget());
}


Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,

  );
}