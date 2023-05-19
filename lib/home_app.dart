import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_app/path_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String? linkMessage;
  bool isCreatingLink = false;

 late FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }


    Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        String? productId = queryParams["id"];
        Navigator.pushNamed(context, dynamicLinkData.link.path,
            arguments: {"productId": int.parse(productId!)});
      } else {
        Navigator.pushNamed(
          context,
          dynamicLinkData.link.path,
        );
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

    Future<void> _createDynamicLink(bool short, String link) async {
    setState(() {
      isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: kUriPrefix,
      link: Uri.parse(kUriPrefix + link),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.deeplink',
        minimumVersion: 0,
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      linkMessage = url.toString();
      isCreatingLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: !isCreatingLink
                            ? ()async => await _createDynamicLink(false, kProductpageLink)
                            : null,
                        child: const Text('Get Long Link'),
                      ),
                      ElevatedButton(
                        onPressed: !isCreatingLink
                            ? ()async => await _createDynamicLink(true, kProductpageLink)
                            : null,
                        child: const Text('Get Short Link'),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (linkMessage != null) {
                        await launchUrl(Uri.parse(linkMessage!));
                      }
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: linkMessage));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied Link!')),
                      );
                    },
                    child: Text(
                      linkMessage ?? '',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            )
    );
  }
}
