import 'package:flutter/material.dart';

class DashboardIteamModel {
  IconData icon;
  String title;

  DashboardIteamModel({
    required this.icon,
    required this.title,
  });

  static const String product = "Products";
  static const String category = "Category";
  static const String order = "Orders";
  static const String user = "Users";
  static const String settings = "Settings";
  static const String report = "Report";
}

final List<DashboardIteamModel> dashboardItems = [
  DashboardIteamModel(
    icon: Icons.card_giftcard,
    title: DashboardIteamModel.product,
  ),
  DashboardIteamModel(
    icon: Icons.category,
    title: DashboardIteamModel.category,
  ),
  DashboardIteamModel(
    icon: Icons.monetization_on,
    title: DashboardIteamModel.order,
  ),
  DashboardIteamModel(
    icon: Icons.person,
    title: DashboardIteamModel.user,
  ),
  DashboardIteamModel(
    icon: Icons.settings,
    title: DashboardIteamModel.settings,
  ),
  DashboardIteamModel(
    icon: Icons.area_chart,
    title: DashboardIteamModel.report,
  ),
];
