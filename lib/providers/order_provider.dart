import 'package:e_commerce_admin_app/db/db_helper.dart';
import 'package:e_commerce_admin_app/models/order_constants_model.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  Future<void> addOrderConstants(OrderConstantsModel orderConstantsModel) =>
      DBHelper.addOrderConstants(orderConstantsModel);

  getOrderConstants() {
    DBHelper.getAllOrderConstants().listen((event) {
      if (event.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(event.data()!);

        notifyListeners();
      }
    });
  }
}
