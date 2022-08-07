import 'package:e_commerce_admin_app/models/dashboard_item_model.dart';
import 'package:e_commerce_admin_app/widgets/dashboard_item_view.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = "/";
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GridView.builder(
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: dashboardItems.length,
            itemBuilder: (context,index)=> DashBoardItemView(dashboardIteam: dashboardItems[index], onPressed: (value){

            })),
      ),
    );
  }
}
