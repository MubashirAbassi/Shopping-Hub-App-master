import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/order.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/provider/cart.dart';
import 'dart:convert';

import 'package:shopping_app/widget/progressdialogue.dart';
import 'package:shopping_app/widget/successdialog.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment';

  String number;
  PaymentScreen({this.number});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String amount;
  final _phonenumberController = TextEditingController();
  var pickupSelected;
  var _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phonenumberController.text = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    amount = (Provider.of<Cart>(context, listen: false).totalAmount).toString();
    // List<DropdownMenuItem<dynamic>> DropDownMenucontrylist = contrylist
    //     .map(
    //       (var value) => DropdownMenuItem(
    //         value: value,
    //         child: Text(value),
    //       ),
    //     )
    //     .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _phonenumberController,
                  keyboardType: TextInputType.phone,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your PhoneNumber';
                    }
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.local_phone_outlined),
                    hintText: 'PhoneNumber',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  // onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 2,
              ),
              FlatButton(
                padding: EdgeInsets.all(15),
                color: Colors.deepOrangeAccent,
                onPressed: () async {
                  print(amount);
                  if (int.parse(amount) < 100) {
                    amount = (int.parse(amount) + 100).toString();
                  }
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ProgressDialog(status: 'Loading...'),
                  );
                  var response =
                      await submit(_phonenumberController.text, amount);
                  Navigator.pop(context);
                  print(response);
                  String message;
                  try {
                    message = (response['pp_ResponseMessage'])
                        .replaceAll('pp_Amount', 'Amount');
                  } catch (e) {
                    message = (response['pp_ResponseMessage']);
                  }
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => SuccessDialog(
                        text: message, status: response['pp_ResponseCode']),
                  );
                  print(amount);
                },
                child: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> payment(
      String phoneNumber, String amount) async {
    var digest;
    String tre =
        "T" + (DateFormat("yyyyMMddHHmmss").format(DateTime.now())).toString();
    String pp_Version = "1.1";
    String pp_TxnType = 'MWALLET';
    String pp_Language = "EN";
    String pp_MerchantID = "MC20567";
    String pp_SubMerchantID = '';
    String pp_Password = "8dt0s9z0cd";
    String pp_BankID = '';
    String pp_ProductID = '';
    String pp_TxnRefNo = tre;
    String pp_Amount = '157';
    String pp_TxnCurrency = 'PKR';

    String pp_TxnDateTime =
        (DateFormat("yyyyMMddHHmmss").format(DateTime.now())).toString();
    String pp_BillReference = 'billRef';
    String pp_Description = 'Description';
    String pp_TxnExpiryDateTime = (DateFormat("yyyyMMddHHmmss")
            .format(DateTime.now().add(Duration(days: 1))))
        .toString();
    String pp_ReturnURL = 'https://www.google.com';
    String pp_SecureHash;
    String ppmpf_1 = phoneNumber;

    String IntegeritySalt = "12vsx97fe3";
    String and = '&';
    String superdata = IntegeritySalt +
        and +
        pp_Amount +
        and +
        pp_BillReference +
        and +
        pp_Description +
        and +
        pp_Language +
        and +
        pp_MerchantID +
        and +
        pp_Password +
        and +
        pp_ReturnURL +
        and +
        pp_TxnCurrency +
        and +
        pp_TxnDateTime +
        and +
        pp_TxnExpiryDateTime +
        and +
        pp_TxnRefNo +
        and +
        pp_TxnType +
        and +
        pp_Version +
        and +
        ppmpf_1;

    var key = utf8.encode(IntegeritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = new Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);
    var url =
        'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

    var response = await http.post(url, body: {
      "pp_Version": pp_Version,
      "pp_TxnType": pp_TxnType,
      "pp_Language": pp_Language,
      "pp_MerchantID": pp_MerchantID,
      "pp_Password": pp_Password,
      "pp_TxnRefNo": tre,
      "pp_Amount": pp_Amount,
      "pp_TxnCurrency": pp_TxnCurrency,
      "pp_TxnDateTime": pp_TxnDateTime,
      "pp_BillReference": pp_BillReference,
      "pp_Description": pp_Description,
      "pp_TxnExpiryDateTime": pp_TxnExpiryDateTime,
      "pp_ReturnURL": pp_ReturnURL,
      "pp_SecureHash": sha256Result.toString(),
      "ppmpf_1": ppmpf_1,
    });

    print("response=> ${(response.body).runtimeType}");
    return (json.decode(response.body));
  }

  Future<Map<String, dynamic>> submit(String phonenumber, String amount) async {
    if (_formkey.currentState.validate()) {
      var response = await payment(phonenumber, amount);
      Provider.of<Auth>(context, listen: false)
          .uploadJazzcashNumber(phonenumber);
      return response;
    }
  }
}
