import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/products.dart';

import '../product_screen.dart';
class Laptop extends StatefulWidget {
  static const routename="/laptop";
  @override
  _LaptopState createState() => _LaptopState();
}

class _LaptopState extends State<Laptop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laptops"),
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
                leading: Icon(FontAwesomeIcons.laptop),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Dell"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Dell");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.laptop),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("HP"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("HP");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.laptop),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Macbook"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Macbook");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.laptop),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Asus"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Asus");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
          ]
      ),
    );
  }
}
