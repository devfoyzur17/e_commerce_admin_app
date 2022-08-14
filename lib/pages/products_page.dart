import 'package:e_commerce_admin_app/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
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


      body: Consumer<ProductProvider>(
          builder: (context, provider, _) => provider.productList.isEmpty
              ? Center(
            child: Text("No product found"),
          )
              : ListView.builder(
              itemCount: provider.productList.length,
              itemBuilder: (context, index) {
                final product = provider.productList[index];
                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, ProductDetailsPage.routeName, arguments: product);
                  },
                  title: Text(
                      "${product.name} (${product.available})"),
                );
              })),



      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, NewProductPage.routeName);
          },
          child: const Icon(Icons.add)),
    );
  }
}
