import 'package:e_commerce_admin_app/pages/dashboard_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: const Color.fromARGB(255, 24, 1, 105),
      100: const Color.fromARGB(255, 6, 150, 59),
      200: const Color.fromARGB(255, 6, 150, 59),
      300: const Color.fromARGB(255, 6, 150, 59),
      400: const Color.fromARGB(255, 6, 150, 59),
      500: const Color.fromARGB(255, 6, 150, 59),
      600: const Color.fromARGB(255, 6, 150, 59),
      700: const Color.fromARGB(255, 6, 150, 59),
      800: const Color.fromARGB(255, 6, 150, 59),
      900: const Color.fromARGB(255, 6, 150, 59),
    };
    MaterialColor appColor = MaterialColor(0xffEE403E, pokeballRedSwatch);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: appColor,
      ),
      initialRoute: DashboardPage.routeName,
      routes: {
        DashboardPage.routeName: (context) => const DashboardPage(),
      },
    );
  }
}
