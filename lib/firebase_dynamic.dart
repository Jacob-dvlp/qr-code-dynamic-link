import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'home_page.dart';

class FirebaseDynamic {
  Future<String> create(String value) async {
    final String url = "https://deepdynamicappflutter.page.link?ref=$value";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: kUriPrefix,
      androidParameters: const AndroidParameters(
        packageName: "com.example.deep_link",
        minimumVersion: 0,
      ),
    );

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);
    print(refLink.shortUrl.toString());
    return refLink.shortUrl.toString();
  }

  Future<void> init() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;
      log(refLink.data.toString());
    }
  }
}
