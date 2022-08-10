import 'package:e_commerce_admin_app/db/db_helper.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier{
  List<ProductModel> productList=[];
  List<CategoryModel> categorylist=[];

  Future<void> addCategory(CategoryModel categoryModel)=>
    DBHelper.addNewCategory(categoryModel);

  getAllCategories(){
    DBHelper.getAllCategories().listen((event) {
      categorylist = List.generate(event.docs.length, (index) =>
      CategoryModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }



}