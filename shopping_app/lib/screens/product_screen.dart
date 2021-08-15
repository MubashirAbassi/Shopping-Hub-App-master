import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/cart.dart';
import 'package:shopping_app/widget/badge.dart';
import 'package:shopping_app/widget/infodialogue.dart';
import 'package:shopping_app/widget/product_list.dart';
import 'package:shopping_app/provider/product.dart';

import '../main.dart';
import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/productscreen';
  String result;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
// void initDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => InfoDialog(),
//     );
//
//     var RequestTimeout = 15;
//     const oneSecondTick = Duration(seconds: 1);
//
//     var timer = Timer.periodic(oneSecondTick, (timer) {
//       RequestTimeout--;
//
//       if (RequestTimeout == 0) {
//         Navigator.pop(context);
//         RequestTimeout = 60;
//
//         timer.cancel();
//       }
//     });
//   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Searched Product", textAlign: TextAlign.center),
        backgroundColor: Colors.teal,
        actions: [
          isAuthorized
              ? Consumer<Cart>(
                  builder: (_, cart, ch) => Badge(
                    child: ch,
                    value: cart.itemCount.toString(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ),
                )
              : Container(),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Productlist(),
      ),
    );
  }
/*  void initDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => InfoDialog(),
    );

    var RequestTimeout = 15;
    const oneSecondTick = Duration(seconds: 1);

    var timer = Timer.periodic(oneSecondTick, (timer) {
      RequestTimeout--;

      if (RequestTimeout == 0) {
        Navigator.pop(context);
        RequestTimeout = 60;

        timer.cancel();
      }
    });
  }*/
}
