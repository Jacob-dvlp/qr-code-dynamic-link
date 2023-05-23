import 'package:deep_link/firebase_dynamic_link.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseDynamicLinkInit());
  }
}
