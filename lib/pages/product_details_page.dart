import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = "product-details-page";
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) =>
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getProductById(pId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              return ListView(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'images/placeholder.jpg',
                    image: product.imageUrl!,
                    fadeInCurve: Curves.bounceInOut,
                    fadeInDuration: const Duration(seconds: 3),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Re-Purchase'),
                      ),
                      TextButton(
                        onPressed: () {
                           provider.getPurchaseByProductId(pId);
                          _showPurchaseHistoryBottomSheet(context);
                        },
                        child: const Text('Purchase History'),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(product.name!),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text('৳${product.salePrice}'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: const Text('Product Description'),
                    subtitle: Text(product.description ?? 'Not Available'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Available'),
                    value: product.available,
                    onChanged: (value) {
                      provider.updateProduct(
                          product.id!, productAvailable, value);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Featured'),
                    value: product.featured,
                    onChanged: (value) {
                      provider.updateProduct(
                          product.id!, productFeatured, value);
                    },
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Failed'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void _showPurchaseHistoryBottomSheet(BuildContext context) {
  showModalBottomSheet(context: context, builder: (context)=> ListView.builder(
      itemCount: context.read<ProductProvider>().purchaseListOfSpecificProduct.length,
      itemBuilder: (context, index){
        final purchaseModel = context.read<ProductProvider>().purchaseListOfSpecificProduct[index];
        return ListTile(
          title: Text(getFormatedDateTime(purchaseModel.dateModel.timestamp.toDate(), "dd/MM/yyyy")),
          subtitle: Text(purchaseModel.quantity.toString()),
          trailing:  Text('৳ ${purchaseModel.purchaseprice} '),
        );

      }
  ));

  }
}
