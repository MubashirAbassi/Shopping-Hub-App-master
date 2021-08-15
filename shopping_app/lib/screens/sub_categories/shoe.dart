import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/products.dart';

import '../product_screen.dart';
class Shoe extends StatefulWidget {
  static const routename="/shoe";
  @override
  _ShoeState createState() => _ShoeState();
}

class _ShoeState extends State<Shoe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoes"),
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
                leading: Icon(FontAwesomeIcons.shoePrints),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Sport Shoe"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Sport Shoe");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.shoePrints),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Leather Shoe"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Leather Shoe");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.shoePrints),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Addidas Shoe"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Addidas Shoe");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.shoePrints),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Nike Shoe"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Nike Shoe");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
          ]
      ),
    );
  }
}
