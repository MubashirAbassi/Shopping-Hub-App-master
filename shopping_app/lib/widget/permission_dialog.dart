import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/cart.dart';

class Permissiondialog extends StatelessWidget {

   final String productid;
  Permissiondialog(this.productid);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('do you want to delete this item?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                   Navigator.of(context).pop();
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () {
                   Navigator.of(context).pop(Provider.of<Cart>(context, listen: false).removeItem(productid));


                  },
                  child: Text('Yes'))
            ],
          );
        }
  //  );}}
}
