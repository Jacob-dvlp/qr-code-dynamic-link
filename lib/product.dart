import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final int? productId;
  const ProductPage({Key? key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Link  "),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Producto",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
