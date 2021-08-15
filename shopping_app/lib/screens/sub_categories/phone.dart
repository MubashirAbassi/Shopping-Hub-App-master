import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/products.dart';

import '../product_screen.dart';
class Phone extends StatefulWidget {
  static const routename="/phone";
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phones"),
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
          title: Text("Samsung Phone"),
          onTap: (){
            Provider.of<Products>(context,listen: false).FetchandSetProducts("Samsung Phone");
            Navigator.of(context).pushNamed(ProductScreen.routeName);
          },
        ),
      ),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.phone),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("Apple Phone"),
              onTap: (){
                Provider.of<Products>(context,listen: false).FetchandSetProducts("Apple Phone");
                Navigator.of(context).pushNamed(ProductScreen.routeName);
              },
            ),
          ),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.phone),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("OPPO Phone"),
              onTap: (){
                Provider.of<Products>(context,listen: false).FetchandSetProducts("OPPO Phone");
                Navigator.of(context).pushNamed(ProductScreen.routeName);
              },
            ),
          ),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.phone),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("LG Phone"),
              onTap: (){
                Provider.of<Products>(context,listen: false).FetchandSetProducts("LG Phone");
                Navigator.of(context).pushNamed(ProductScreen.routeName);
              },
            ),
          ),
     ]
    ),
    );
  }
}
