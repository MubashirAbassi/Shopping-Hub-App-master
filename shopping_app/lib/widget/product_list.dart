import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/products.dart';
import 'package:shopping_app/widget/product_item.dart';

class Productlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return products.length == 0
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: Productitem(
                    /*products[i].id, products[i].title,
                   products[i].discription,
                   products[i].imageurl,
                   products[i].price)*/
                    )));
  }
}
