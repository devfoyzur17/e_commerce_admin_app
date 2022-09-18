import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_app/db/db_helper.dart';
import 'package:e_commerce_admin_app/models/order_constants_model.dart';
import 'package:e_commerce_admin_app/utils/contstants.dart';
import 'package:flutter/cupertino.dart';

import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();
  List<OrderModel> orderList = [];

  Future<void> addOrderConstants(OrderConstantsModel orderConstantsModel) =>
      DBHelper.addOrderConstants(orderConstantsModel);

  Future<void> getOrderConstants() async {
    final snapshot = await DBHelper.getAllOrderConstants();
    orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
    notifyListeners();
  }

  void getAllOrders() {
    DBHelper.getAllOrders().listen((event) {
      orderList = List.generate(event.docs.length,
          (index) => OrderModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  num getTotalOrderByDate(DateTime dateTime) {
    final filterDate = orderList
        .where((element) =>
            element.orderDate.day == dateTime.day &&
            element.orderDate.month == dateTime.month &&
            element.orderDate.year == dateTime.year)
        .toList();
    return filterDate.length;
  }

  num getTotalSaleByDate(DateTime dateTime) {
    num total = 0;
    final filterDate = orderList
        .where((element) =>
            element.orderDate.day == dateTime.day &&
            element.orderDate.month == dateTime.month &&
            element.orderDate.year == dateTime.year)
        .toList();
    for (var order in filterDate) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalOrderByDateRange(DateTime dateTime) {
    final filterDate = orderList
        .where(
            (element) => element.orderDate.timestamp.toDate().isAfter(dateTime))
        .toList();
    return filterDate.length;
  }

  num getTotalSaleByDateRange(DateTime dateTime) {
    num total = 0;
    final filterDate = orderList
        .where(
            (element) => element.orderDate.timestamp.toDate().isAfter(dateTime))
        .toList();
    for (var order in filterDate) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getAllTimeTotalSale() {
    num total = 0;

    for (var order in orderList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  List<OrderModel> getFilterOrderList(OrderFilter orderFilter) {
    var filterList = <OrderModel>[];

    switch (orderFilter) {
      case OrderFilter.TODAY:
        filterList = orderList
            .where((element) =>
                element.orderDate.day == DateTime.now().day &&
                element.orderDate.month == DateTime.now().month &&
                element.orderDate.year == DateTime.now().year)
            .toList();
        break;
      case OrderFilter.YESTERDAY:
        filterList = orderList
            .where((element) =>
                element.orderDate.day == DateTime.now().day - 1 &&
                element.orderDate.month == DateTime.now().month &&
                element.orderDate.year == DateTime.now().year)
            .toList();
        break;
      case OrderFilter.SEVEN_DAYS:
        filterList = orderList
            .where((element) => element.orderDate.timestamp
                .toDate()
                .isAfter(DateTime.now().subtract(const Duration(days: 7))))
            .toList();
        break;
      case OrderFilter.THIS_MONTH:
        filterList = orderList
            .where((element) => element.orderDate.timestamp
                .toDate()
                .isAfter(DateTime(DateTime.now().year, DateTime.now().month)))
            .toList();
        break;
      case OrderFilter.ALL_TIME:
        filterList = orderList;
        break;
    }
    return filterList;
  }
}
