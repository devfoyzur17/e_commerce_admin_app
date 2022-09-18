import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_app/pages/orderListPage.dart';
import 'package:e_commerce_admin_app/providers/order_provider.dart';
import 'package:e_commerce_admin_app/utils/contstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  static const routeName = "order-page";
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView(
          padding: EdgeInsets.all(10),
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  children: [
                    const Text(
                      "Today",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          letterSpacing: 1,
                          wordSpacing: 1),
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.9,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Total Orders"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "${provider.getTotalOrderByDate(Timestamp.now().toDate())}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Total Sale"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "\৳${provider.getTotalSaleByDate(DateTime.now())}"),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, OrderListPage.routeName,
                            arguments: OrderFilter.TODAY),
                        child: Text("View All"))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  children: [
                    const Text(
                      "Yesterday",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          letterSpacing: 1,
                          wordSpacing: 1),
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.9,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Total Orders"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "${provider.getTotalOrderByDate(DateTime.now().subtract(Duration(days: 1)))}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Total Sale"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "\৳${provider.getTotalSaleByDate(DateTime.now().subtract(Duration(days: 1)))}"),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, OrderListPage.routeName,
                            arguments: OrderFilter.YESTERDAY),
                        child: Text("View All"))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  children: [
                    const Text(
                      "Last 7 days",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          letterSpacing: 1,
                          wordSpacing: 1),
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.9,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Total Orders"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "${provider.getTotalOrderByDateRange(DateTime.now().subtract(Duration(days: 7)))}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Total Sale"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "\৳${provider.getTotalSaleByDateRange(DateTime.now().subtract(Duration(days: 7)))}"),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, OrderListPage.routeName,
                            arguments: OrderFilter.SEVEN_DAYS),
                        child: Text("View All"))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  children: [
                    const Text(
                      "This month",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          letterSpacing: 1,
                          wordSpacing: 1),
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.9,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Total Orders"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "${provider.getTotalOrderByDateRange(DateTime(DateTime.now().year, DateTime.now().month - 1))}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Total Sale"),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "\৳${provider.getTotalSaleByDateRange(DateTime(DateTime.now().year, DateTime.now().month - 1))}"),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, OrderListPage.routeName,
                            arguments: OrderFilter.THIS_MONTH),
                        child: Text("View All"))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  children: [
                    const Text(
                      "All Time",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          letterSpacing: 1,
                          wordSpacing: 1),
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.9,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Total Orders"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("${provider.orderList.length}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Total Sale"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("\৳${provider.getAllTimeTotalSale()}"),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, OrderListPage.routeName,
                            arguments: OrderFilter.ALL_TIME),
                        child: Text("View All"))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
