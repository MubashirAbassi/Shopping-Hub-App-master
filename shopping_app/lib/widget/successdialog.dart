import 'package:flutter/material.dart';

import '../screens/allproduct_screen.dart';
import '../screens/allproduct_screen.dart';

class SuccessDialog extends StatelessWidget {
  String text;
  String status;
  SuccessDialog({this.text,this.status});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Instruction',
                  style: TextStyle(fontSize: 22.0, fontFamily: 'Brand-Bold'),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                  ),
                ),
                status == '000'? Row(
                  children: [
                    Expanded(child: TextButton(onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, Allproduct.routeName, (route) => false);
                    }, child: Text('Okay'))),
                  ],
                ):Row(
                  children: [
                    Expanded(child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('TryAgaun'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
