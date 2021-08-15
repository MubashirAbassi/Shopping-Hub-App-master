import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/product.dart';
import 'package:shopping_app/provider/cart.dart';
import 'package:shopping_app/screens/productdetail_screen.dart';

class Productitem extends StatelessWidget {
/*  final String id;
  final String title;
  final String discription;
  final String imageurl;
  final double price;

  const Productitem(
      this.id, this.title, this.discription, this.imageurl, this.price);
*/
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          child: Image.network(
            product.imageurl,
            // fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          Productdetail.routName,
          arguments: product.id,
        );
      },
      title: Text(
        product.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(product.discription),
      trailing: IconButton(
        icon: Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          cart.addItem(product.id, product.price, product.title,product.imageurl);
        },
        //color: Theme.of(context).accentColor,
      ),
    );
  }
}
