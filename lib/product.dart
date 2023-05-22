import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class ProductPage extends StatefulWidget {
  final String? productId;
  const ProductPage({Key? key, this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Post? posts;
  bool isLoading = false;

  Future getPost() async {
    isLoadingData(true);
    Future.delayed(
      const Duration(seconds: 4),
      () {},
    );
    final response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/${widget.productId}"));
    if (response.statusCode == 200) {
      setState(() {
        final _res = isNotList(response.body);
        posts = _res;
        isLoadingData(false);
      });
    }
  }

  isLoadingData(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(posts!.id.toString()),
                ),
                title: Text(posts!.title),
        ),
      ),
    );
  }
}
