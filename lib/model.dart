// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
Post isNotList(String str) => Post.fromJson(json.decode(str));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    int userId;
    int id;
    String title;
    String body;

    Post({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}






// import 'dart:convert';

// import 'package:deep_link/model.dart';
// import 'package:deep_link/product.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// class HomeApp extends StatefulWidget {
//   const HomeApp({Key? key}) : super(key: key);

//   @override
//   State<HomeApp> createState() => _HomeAppState();
// }

// class _HomeAppState extends State<HomeApp> {

//   String? linkMessage;
//   bool isCreatingLink = false;
//   List<Post> posts = [];



//   late FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

//   @override
//   void initState() {
//     super.initState();
//     getPost();
//     initDynamicLinks();
//   }

//   Future<void> initDynamicLinks() async {
//     dynamicLinks.onLink.listen((dynamicLinkData) {
//       final Uri uri = dynamicLinkData.link;
//       final queryParams = uri.queryParameters;
//       print(queryParams);
//       if (queryParams.isNotEmpty) {
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ProductPage(),
//             ));
//       } else {
//         Navigator.pushNamed(
//           context,
//           dynamicLinkData.link.path,
//         );
//       }
//     }).onError((error) {
//       print('onLink error');
//       print(error.message);
//     });
//   }

//   Future<void> _createDynamicLink(bool short, String id, String route) async {
//     setState(() {
//       isCreatingLink = true;
//     });

//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: kUriPrefix,
//       link: Uri.parse("https://deepdynamicappflutter.page.link?ref=$route"),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.example.deep_link',
//         minimumVersion: 0,
//       ),
//     );

//     Uri url;
//     url = await dynamicLinks.buildLink(parameters);


//     setState(() {
//       linkMessage = url.toString();

//     print(linkMessage);
//       isCreatingLink = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(''),
//         ),
//         body: ListView.builder(
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final Post post = posts[index];
//             return Card(
//               child: ListTile(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProductPage(productId: post.id),
//                       ));
//                 },
//                 leading: CircleAvatar(
//                   child: Text(post.id.toString()),
//                 ),
//                 title: Text(post.title),
//                 trailing:GestureDetector(
//                   onTap: () => _createDynamicLink(true, post.id.toString(),kProductpageLink),
//                   child: const CircleAvatar(
//                     child: Icon(Icons.copy),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ));
//   }
// }

// const String kUriPrefix = 'https://deepdynamicappflutter.page.link';
// const String kHomepageLink = '/homepage';
// const String kProductpageLink = '/homepage';


// // Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               ButtonBar(
// //                 alignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   ElevatedButton(
// //                     onPressed: !isCreatingLink
// //                         ? () async =>
// //                             await _createDynamicLink(false, kProductpageLink)
// //                         : null,
// //                     child: const Text('Get Long Link'),
// //                   ),
// //                   ElevatedButton(
// //                     onPressed: !isCreatingLink
// //                         ? () async =>
// //                             await _createDynamicLink(true, kProductpageLink)
// //                         : null,
// //                     child: const Text('Get Short Link'),
// //                   ),
// //                 ],
// //               ),
// //               InkWell(
// //                 onTap: () async {
// //                   if (linkMessage != null) {
// //                     await launch(linkMessage!);
// //                   }
// //                 },
// //                 onLongPress: () {
// //                   Clipboard.setData(ClipboardData(text: linkMessage));
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     const SnackBar(content: Text('Copied Link!')),
// //                   );
// //                 },
// //                 child: Text(
// //                   linkMessage ?? '',
// //                   style: const TextStyle(color: Colors.blue),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         )