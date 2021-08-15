import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/products.dart';

import '../product_screen.dart';
class Bag extends StatefulWidget {
  static const routename="/bag";
  @override
  _BagState createState() => _BagState();
}

class _BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bags"),
        backgroundColor: Colors.teal,
      ),
      body:  ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(3),
          children: [
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.phone),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("School bag"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("School bag");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.phone),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Shopping bag"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Shopping bag");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.phone),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Handbag"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Handbag");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.phone),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Laptop bag"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Laptop bag");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
          ]
      ),
    );
  }
}
