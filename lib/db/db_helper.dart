import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/models/purchase_model.dart';

class DBHelper{

  static String adminCollection = "Admins";
  static String collectionCategory = "Category";
  static String collectionProducts = "Products";
  static String collectionPurchase = "Purchase";
  static String collectionUsers = "User";
  static String collectionOrder = "Order";
  static String collectionOrderDetails = "OrderDetails";
  static String collectionSettings = "Setting";
  static String documentConstant = "OrderConstant";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async{
    final snapshot = await _db.collection(adminCollection).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addNewCategory(CategoryModel categoryModel){
    final doc = _db.collection(collectionCategory).doc();
    categoryModel.catId = doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Future<void> addProduct(
      ProductModel productModel,
      PurchaseModel purchaseModel,
      String catId,
      num count,
      ){
    final wb = _db.batch();
    final proDoc = _db.collection(collectionProducts).doc();
    final purDoc = _db.collection(collectionPurchase).doc();
    final catDoc = _db.collection(collectionCategory).doc(catId);
    productModel.id = proDoc.id;
    purchaseModel.id = purDoc.id;
    purchaseModel.productID = proDoc.id;

    wb.set(proDoc, productModel.toMap());
    wb.set(purDoc, purchaseModel.toMap());
    wb.update(catDoc, {categoryProductCount : count});

    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories()=>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts()=>
      _db.collection(collectionProducts).snapshots();



}