import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/products.dart';

import '../product_screen.dart';
class Watch extends StatefulWidget {
  static const routename="/watch";
  @override
  _WatchState createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watches"),
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
                leading: Icon(FontAwesomeIcons.clock),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Leather Watch"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Leather Watch");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.clock),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Wrist Watch"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Wrist Watch");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.clock),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Rado Watch"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Rado Watch");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.clock),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("Casso Watch"),
                onTap: (){
                  Provider.of<Products>(context,listen: false).FetchandSetProducts("Casso Watch");
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
            ),
          ]
      ),
    );
  }
}
