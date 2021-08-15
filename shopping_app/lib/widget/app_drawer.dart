import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/allproduct_screen.dart';
import 'package:shopping_app/screens/edit_profile.dart';

import 'package:shopping_app/screens/order_screen.dart';
import 'package:shopping_app/screens/user_screen.dart';
import 'package:shopping_app/screens/welcome_page.dart';

import '../provider/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.teal,
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_rounded),
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(EditProfile.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async{
              await Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  WelcomeScreen.routeName, (route) => false);
            },
          )
        ],
      ),
    );
  }
}
