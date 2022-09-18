import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/pages/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailsPage.routeName, arguments: product.id);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInImage.assetNetwork(
               image: product.imageUrl.toString(),
                height: 100,
                placeholder: "assets/images/photos.png",
                fadeInCurve: Curves.bounceInOut,
                fadeInDuration: const Duration(seconds: 2),
              ),
              Text(
                product.name.toString(),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              Text("Stock: ${product.stock}", style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}
