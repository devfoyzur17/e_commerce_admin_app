import 'package:e_commerce_admin_app/models/order_model.dart';
import 'package:e_commerce_admin_app/providers/order_provider.dart';
import 'package:e_commerce_admin_app/utils/contstants.dart';
import 'package:e_commerce_admin_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatelessWidget {
  static const routeName = "/order-list-page";
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderModel = ModalRoute.of(context)!.settings.arguments as OrderFilter;
   final  orderList =   Provider.of<OrderProvider>(context).getFilterOrderList(orderModel);
    return Scaffold(
      appBar: AppBar(
        title:   Text("Order List"),
      ),

      body: ListView.builder(
      itemCount: orderList.length,
    itemBuilder: (context, index) => Card(
      elevation: 2,
      child: ListTile(
        
        title: Text("\৳${orderList[index].grandTotal}"),
      trailing: Text(getFormatedDateTime(orderList[index].orderDate.timestamp.toDate(), "dd/MM/yyy")),

      ),
    )));
  }
}
