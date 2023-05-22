import 'package:deep_link/product.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
String? linkMessage;
  bool isCreatingLink = false;
List<Post> posts = [];

  late FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    getPost();
  }

  Future getPost() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      setState(() {
        final _res = postFromJson(response.body);
        posts = _res;
      });
      print(posts);
    }
  } 

   initDynamicLinks()  {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      final id = queryParams["param"];
     
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(productId: id!),
            ));
      
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> _createDynamicLink(bool short, String link, String id) async {
    setState(() {
      isCreatingLink = true;
    });

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

    print(dynamicLinks.buildShortLink(parameters).then((value) => print(value.shortUrl)));
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
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final Post post = posts[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(post.id.toString()),
                ),
                title: Text(post.title),
                trailing: InkWell(
                onTap: () async {
                      _createDynamicLink(
                          true, kHomepageLink, post.id.toString());
                  if (linkMessage != null) {
                        await launch(linkMessage!);
                        Clipboard.setData(ClipboardData(text: linkMessage));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied Link!')),
                  );
                        print(linkMessage);
                      }
                  
                },

                
                    child: const CircleAvatar(
                      child: Icon(Icons.copy),
                    )
                ),
              ),
            );
          },
        ));
  }
}



const String kUriPrefix = 'https://deepdynamicappflutter.page.link';
const String kHomepageLink = '/homepage';
const String kProductpageLink = '/homepage';


