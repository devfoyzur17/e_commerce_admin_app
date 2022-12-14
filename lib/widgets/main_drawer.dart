// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce_admin_app/auth/auth_service.dart';
import 'package:e_commerce_admin_app/pages/launcher_page.dart';
import 'package:flutter/material.dart'; 

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Drawer(
      child:  Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: Size.square(70),
            currentAccountPicture: Image.asset("assets/images/person.png"),
            accountName:  Text("Foyzur Rahaman"), 
            accountEmail:  Text("foyzur17@gmail.com")),

            Expanded(child: ListView(
              children: [
                ListTile(
                  onTap: (){

                    AuthService.logout();
                    
                    Navigator.pushReplacementNamed(context, LauncherPage.routeName);
                  },
                  leading: Icon(Icons.logout),
                  title: Text("LogOut"),
                )
              ],
            ))
        ],
      ) 
    );
    
  }
}