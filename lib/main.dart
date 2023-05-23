
import 'package:deep_link/firebase_dynamic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_dynamic_link.dart';

Future<void> main() async {
  await init();
await FirebaseDynamicLinkInit().initDynamicLinks();
  runApp(const AppWidget());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp();
  FirebaseDynamic().init();

}
