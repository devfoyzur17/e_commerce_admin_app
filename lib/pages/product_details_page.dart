import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/providers/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = "product-details-page";
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: ListView(
        children: [
          FadeInImage.assetNetwork(
              placeholder: "assets/images/photos.png",
              image: product.imageUrl!

          )
        ],
      ),

    );
  }
}
