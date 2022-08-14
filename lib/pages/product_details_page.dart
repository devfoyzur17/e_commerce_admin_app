import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = "product-details-page";
    ProductDetailsPage({Key? key}) : super(key: key);
  final txtContoller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final pId = ModalRoute.of(context)!.settings.arguments as String;
    Provider.of<ProductProvider>(context).getPurchaseByProductId(pId);
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
                  Container(
                    color: Colors.white,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'images/placeholder.jpg',
                      image: product.imageUrl!,
                      fadeInCurve: Curves.bounceInOut,
                      fadeInDuration: const Duration(seconds: 3),
                      width: double.infinity,
                      height: 300,

                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(

                            borderRadius:  BorderRadius.circular(15),

                          ),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor
                          )
                        ),
                        onPressed: () {},
                        child: const Text('Re-Purchase'),
                      ),
                     SizedBox(width: 20,),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(

                              borderRadius:  BorderRadius.circular(15),

                            ),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor
                            )
                        ),
                        onPressed: () {
                          _showPurchaseHistoryBottomSheet(context);
                        },
                        child: const Text('Purchase History'),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(product.name!),
                    trailing: IconButton(
                      onPressed: () {
                         showUpdateDialog(context, "Name", product.name, (value) {

                           provider.updateProduct(product.id!, productName, value);

                         });


                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text('৳${product.salePrice.toString()}'),
                    trailing: IconButton(
                      onPressed: () {
                        showUpdateDialog(context, "Price", product.salePrice.toString(), (value) {

                         provider.updateProduct(product.id!, productSalePrice, num.parse(value));

                        });

                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: const Text('Product Description'),
                    subtitle: Text(product.description ?? 'Not Available'),
                    trailing: IconButton(
                      onPressed: () {
                        showUpdateDialog(context, "Description", product.description, (value) {

                          provider.updateProduct(product.id!, productDescription, value);

                        });

                      },
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


  showUpdateDialog(BuildContext context,String title, String? value, Function(String) onSaved) {
    txtContoller.text = value ?? "";
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Update $title",textAlign: TextAlign.center,),
          content: TextFormField(
            controller: txtContoller,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffe6e6e6),
                contentPadding: const EdgeInsets.only(left: 10),
                focusColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.workspaces_filled,
                ),
                hintText: "Enter $title",
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field must not be empty';
              } else {
                return null;
              }
            },
          ),

          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  onSaved(txtContoller.text);
                  Navigator.pop(context);
                },
                child: Text("Update"))
          ],
        ));
  }
}
