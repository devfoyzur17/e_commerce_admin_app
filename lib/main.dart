import 'package:e_commerce_admin_app/pages/category_page.dart';
import 'package:e_commerce_admin_app/pages/dashboard_page.dart';
import 'package:e_commerce_admin_app/pages/launcher_page.dart';
import 'package:e_commerce_admin_app/pages/login_page.dart';
import 'package:e_commerce_admin_app/pages/new_product_page.dart';
import 'package:e_commerce_admin_app/pages/order_page.dart';
import 'package:e_commerce_admin_app/pages/products_page.dart';
import 'package:e_commerce_admin_app/pages/report_page.dart';
import 'package:e_commerce_admin_app/pages/setting_page.dart';
import 'package:e_commerce_admin_app/pages/user_page.dart';
import 'package:e_commerce_admin_app/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> ProductProvider()),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: const Color.fromARGB(255, 17, 156, 105),
      100: const Color.fromARGB(255, 17, 156, 105),
      200: const Color.fromARGB(255, 17, 156, 105),
      300: const Color.fromARGB(255, 17, 156, 105),
      400: const Color.fromARGB(255, 17, 156, 105),
      500: const Color.fromARGB(255, 17, 156, 105),
      600: const Color.fromARGB(255, 17, 156, 105),
      700: const Color.fromARGB(255, 17, 156, 105),
      800: const Color.fromARGB(255, 17, 156, 105),
      900: const Color.fromARGB(255, 17, 156, 105),
    };
    MaterialColor appColor = MaterialColor(0xff119c69, pokeballRedSwatch);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: appColor, 
      ),
      initialRoute: LauncherPage.routeName,
      routes: {

        LauncherPage.routeName: (context) => const LauncherPage(),
        DashboardPage.routeName: (context) => const DashboardPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        NewProductPage.routeName: (context) => const NewProductPage(),
        OrderPage.routeName: (context) => const OrderPage(),
        ProductPage.routeName: (context) => const ProductPage(),
        ReportPage.routeName: (context) => const ReportPage(),
        SettingPage.routeName: (context) => const SettingPage(),
        UserPage.routeName: (context) => const UserPage(),
      },
    );
  }
}
