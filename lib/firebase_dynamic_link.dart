// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:deep_link/home_page.dart';
import 'package:deep_link/product.dart';
import 'package:get/get.dart';

class FirebaseDynamicLinkInit extends GetxController {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        print(dynamicLinkData.link.path);
        final id = queryParams["param"];
        Navigator.pushNamed(Get.context!, "/productpage",
            arguments: {"productId": id!});
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<String> createDynamicLink(bool short, String link, String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: kUriPrefix,
      link: Uri.parse(
          "https://deepdynamicappflutter.page.link?param=$link&param=$id"),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.deep_link',
        minimumVersion: 0,
      ),
    );

    Uri url;
    url = await dynamicLinks.buildLink(parameters);

    print(dynamicLinks
        .buildShortLink(parameters)
        .then((value) => print(value.shortUrl)));

    String linkMessage = url.toString();
    return linkMessage;
  }
}
