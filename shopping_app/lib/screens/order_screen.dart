import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/provider/order.dart' show Orders;
import 'package:shopping_app/widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Your Orders'),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
        ),
      ),
    );
  }
}
