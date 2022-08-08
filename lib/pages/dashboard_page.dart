import 'package:e_commerce_admin_app/auth/auth_service.dart';
import 'package:e_commerce_admin_app/models/dashboard_item_model.dart';
import 'package:e_commerce_admin_app/pages/category_page.dart';
import 'package:e_commerce_admin_app/pages/launcher_page.dart';
import 'package:e_commerce_admin_app/pages/order_page.dart';
import 'package:e_commerce_admin_app/pages/products_page.dart';
import 'package:e_commerce_admin_app/pages/report_page.dart';
import 'package:e_commerce_admin_app/pages/setting_page.dart';
import 'package:e_commerce_admin_app/pages/user_page.dart';
import 'package:e_commerce_admin_app/widgets/dashboard_item_view.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = "dash-board-page";
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(onPressed: (){
            AuthService.logout();
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);

    }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemCount: dashboardItems.length,
            itemBuilder: (context, index) => DashBoardItemView(
                dashboardIteam: dashboardItems[index], onPressed: (value) {


                String route =   navigator(value);
                Navigator.pushNamed(context, route);



            })),
      ),
    );
  }

  String navigator(String value) {
    String route ="";
    switch(value){
      case DashboardIteamModel.user:
        route = UserPage.routeName;
        break;
      case DashboardIteamModel.settings:
        route = SettingPage.routeName;
        break;
      case DashboardIteamModel.category:
        route = CategoryPage.routeName;
        break;
      case DashboardIteamModel.order:
        route = OrderPage.routeName;
        break;
      case DashboardIteamModel.report:
        route = ReportPage.routeName;
        break;
      case DashboardIteamModel.product:
        route = ProductPage.routeName;
        break;

    }
    return route;


  }
}
