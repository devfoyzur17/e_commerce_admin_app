import 'package:flutter/material.dart';

import 'new_product_page.dart';

class ProductPage extends StatelessWidget {
  static const routeName = "product-page";
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, NewProductPage.routeName);
          },
          child: const Icon(Icons.add)),
    );
  }
}
