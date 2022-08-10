// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:e_commerce_admin_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  static const routeName = "new-product-page";
  const NewProductPage({Key? key}) : super(key: key);

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productSalePriceController = TextEditingController();
  final productPurchasePriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productSalePriceController.dispose();
    productPurchasePriceController.dispose();
    productQuantityController.dispose();

    super.dispose();
  }

  String? _purchaseDate;

  String? bookCategory;
  String? imagePatch;

  ImageSource source = ImageSource.camera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                // alignment: Alignment.bottomRight,
                children: [
                  Center(
                    child: imagePatch == null
                        ? Image.asset(
                            "assets/images/photos.png",
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(
                              imagePatch!,
                            ),
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      bottom: -5,
                      right: MediaQuery.of(context).size.width / 2 - 80,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      elevation: 10,
                                      actions: [
                                        ListTile(
                                          onTap: () {
                                            source = ImageSource.camera;
                                            _getImage();
                                            Navigator.of(context).pop();
                                          },
                                          title: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.deepOrange,
                                          ),
                                          subtitle: Text(
                                            "Image from camera",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            source = ImageSource.gallery;
                                            _getImage();
                                            Navigator.of(context).pop();
                                          },
                                          title: Icon(
                                            Icons.photo_library_outlined,
                                            color: Colors.deepOrange,
                                          ),
                                          subtitle: Text(
                                            "Image from Gallery",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.black87,
                            size: 35,
                          )))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // todo Product Name Textfield section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productNameController,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffe6e6e6),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.card_giftcard,
                    ),
                    hintText: "Enter the product name",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
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
            ),

            // todo Product Sale Price Textfield section

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productSalePriceController,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffe6e6e6),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.monetization_on_outlined,
                    ),
                    hintText: "Enter the product sale price",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
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
            ),

            // todo Product Purchase Price Textfield section

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productPurchasePriceController,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffe6e6e6),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.monetization_on,
                    ),
                    hintText: "Enter the product purchase price",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
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
            ),
            // todo Product Quantity Textfield section

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productQuantityController,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffe6e6e6),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.clean_hands_outlined,
                    ),
                    hintText: "Enter the product quantity",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
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
            ),
          //todo Product Description Textfield section

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productDescriptionController,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffe6e6e6),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.description,
                    ),
                    hintText: "Enter the product description",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
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
            ),

            //todo Purchase Date Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Color(0xffe6e6e6),
                leading: Text(
                  "Purchase Date:",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                title: Center(
                  child: Text(
                    _purchaseDate == null
                        ? "No date choisen!"
                        : _purchaseDate.toString(),
                    style: TextStyle(
                        color: _purchaseDate == null
                            ? Colors.grey
                            : Theme.of(context).primaryColor),
                  ),
                ),
                trailing: IconButton(
                    onPressed: _showPurchaseDatePicker,
                    icon: Icon(
                      Icons.add,
                      color: Colors.red,
                    )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ProductProvider>(
                builder: (context, provider, _) => ListTile(
                  tileColor: Color(0xffe6e6e6),
                  leading: Text(
                    "Select category:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  trailing: DropdownButton(
                    hint: Text("No category selected",style: TextStyle(color: Colors.grey),),

                    borderRadius: BorderRadius.circular(20),
                    underline: Text(""),
                    dropdownColor: Colors.white,
                    value: bookCategory,
                    icon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.red,
                      ),
                    ),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500),
                    items: provider.categorylist.map((items) {
                      return DropdownMenuItem(
                        value: items.catName,
                        child: Center(child: Text(items.catName.toString())),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        bookCategory = newValue.toString();
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            ElevatedButton(
                onPressed: _addProduct,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Product",
                    style: TextStyle(fontSize: 16),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        imagePatch = pickedImage.path;
      });
    }
  }

  void _showPurchaseDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        _purchaseDate = DateFormat("yyy/MM/dd").format(selectedDate);
      });
    }
  }

  void _addProduct() {}
}
