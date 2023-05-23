import 'package:deep_link/firebase_dynamic_link.dart';
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


  @override
  void initState() {
    super.initState();
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
                      FirebaseDynamicLinkInit().createDynamicLink(
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
const String kHomepageLink = '/productpage';
const String kProductpageLink = '/homepage';


