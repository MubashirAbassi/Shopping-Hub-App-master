import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:shopping_app/screens/payment/payment_screen.dart';
import 'package:shopping_app/widget/progressdialogue.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../provider/cart.dart';
import '../after_skip.dart';

class PaymentMethodPage extends StatefulWidget {
  static const routeName = "/paymentmethod";

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Success' + response.paymentId),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed' + response.message),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _razorpay.clear(); // Removes all listeners
  }

  void openCheckOut() {
    String amount =
        ((Provider.of<Cart>(context, listen: false).totalAmount) * 100)
            .toString();
    var options = {
      'key': 'rzp_test_iYRASBzMfwH4yN',
      'amount': amount,
      'name': 'ShoppingApp',
      'description': 'Test Payment',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm'],
      }
    };

    // var options = {
    //   'key': 'rzp_test_iYRASBzMfwH4yN',
    //   'amount': 100,
    //   'name': 'Acme Corp.',
    //   'description': 'Fine T-Shirt',
    //   'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    // };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Selection"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: FlatButton(
                padding: EdgeInsets.all(15),
                color: Colors.teal,
                onPressed: () async {
                  // Navigator.of(context).pushNamed(PaymentScreen.routeName);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ProgressDialog(status: 'Loading...'),
                  );
                  Map response1 =
                  await (Provider.of<Auth>(context, listen: false)
                      .fetchJazzcashNumber());
                  List keys = [];
                  response1.forEach((key, value) {
                    keys.add(key);
                  });

                  String number = response1[keys[1]]['jazzcashNumber'];
                  print(number);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        number: number,
                      ),
                    ),
                  );
                  // Navigator.pop(context);
                },
                child: Text(
                  'Jazzcash',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: FlatButton(
                padding: EdgeInsets.all(15),
                color: Colors.teal,
                onPressed: () async {
                  // Navigator.of(context).pushNamed(PaymentScreen.routeName);

                  await openCheckOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, Allproduct.routeName, (route) => false);
                },
                child: Text(
                  'Card',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            // Padding(
            //   padding:
            //   EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            //   child: FlatButton(
            //     padding: EdgeInsets.all(15),
            //     color: Colors.teal,
            //     onPressed: (null) ,
            //     child: Text(
            //       'Add card',
            //       style: TextStyle(color: Colors.white, fontSize: 20.0),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
