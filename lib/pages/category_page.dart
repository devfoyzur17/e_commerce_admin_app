import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  static const routeName ="category-page";
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
    );
  }
}
