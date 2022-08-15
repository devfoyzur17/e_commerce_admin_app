import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_app/db/db_helper.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/models/date_model.dart';
import 'package:e_commerce_admin_app/models/purchase_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<PurchaseModel> purchaseListOfSpecificProduct = [];
  List<CategoryModel> categoryList = [];

  Future<void> addCategory(CategoryModel categoryModel) =>
      DBHelper.addNewCategory(categoryModel);

  Future<void> rePurchase(String pId, num quantity, num price, DateTime date) {
    final purchaseModel = PurchaseModel(
        dateModel: DateModel(
            timestamp: Timestamp.fromDate(date),
            year: date.year,
            month: date.month,
            day: date.day),
        purchaseprice: price,
        quantity: quantity,
      productID: pId

    );

    return DBHelper.rePurchase(purchaseModel);
  }

  Future<void> addNewProduct(
    ProductModel productModel,
    PurchaseModel purchaseModel,
    CategoryModel categoryModel,
  ) {
    final count = categoryModel.categoryCount + purchaseModel.quantity;
    return DBHelper.addProduct(
        productModel, purchaseModel, categoryModel.catId!, count);
  }

  getAllCategories() {
    DBHelper.getAllCategories().listen((event) {
      categoryList = List.generate(event.docs.length,
          (index) => CategoryModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  getAllProducts() {
    DBHelper.getAllProducts().listen((event) {
      productList = List.generate(event.docs.length,
          (index) => ProductModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  getPurchaseByProductId(String id) {
    DBHelper.getPurchaseByProductId(id).listen((event) {
      purchaseListOfSpecificProduct = List.generate(event.docs.length,
          (index) => PurchaseModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  CategoryModel getCategoryModelByCatName(String name) {
    return categoryList.firstWhere((element) => element.catName == name);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) =>
      DBHelper.getProductById(id);

  Future<void> updateProduct(String id, String field, dynamic value) {
    return DBHelper.updateProduct(id, {field: value});
  }

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime.now().microsecondsSinceEpoch.toString();
    final photoRef = FirebaseStorage.instance.ref().child("picture/$imageName");
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
}
