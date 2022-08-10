import 'dart:io';

import 'package:e_commerce_admin_app/db/db_helper.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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


  Future<String> updateImage(XFile xFile) async{
    final imageName = DateTime.now().microsecondsSinceEpoch.toString();
    final photoRef = FirebaseStorage.instance.ref().child("picture/$imageName");
    final uploadTask =  photoRef.putFile(File(xFile.path));
    final snapshot =   await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }



}