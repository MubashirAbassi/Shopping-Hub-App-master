import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/product.dart';
import 'package:shopping_app/provider/products.dart';
import 'package:shopping_app/screens/product_screen.dart';
import 'package:shopping_app/screens/sub_categories/bags.dart';
import 'package:shopping_app/screens/sub_categories/phone.dart';
import 'package:shopping_app/widget/app_drawer.dart';
import 'package:shopping_app/widget/badge.dart';
import 'package:shopping_app/provider/cart.dart';
import 'package:shopping_app/widget/infodialogue.dart';
import 'package:shopping_app/widget/product_list.dart';
import 'package:shopping_app/widget/progressdialogue.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:shopping_app/screens/sub_categories/watch.dart';
import 'package:shopping_app/screens/sub_categories/shoe.dart';
import 'package:shopping_app/screens/sub_categories/laptop.dart';

import '../main.dart';
import 'cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class Allproduct extends StatefulWidget {
  static String routeName = '/allproduct';

  @override
  _AllproductState createState() => _AllproductState();
}

class _AllproductState extends State<Allproduct> {
  var _showOnlyFavorites = false;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  final _search = TextEditingController();
  //String resultText = _search.text;

  @override
  void initState() {
    initSpeechRecognizer();
    super.initState();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );
    void onRecognitionResult(String text) {
      setState(() {
        _search.text = text;
        // print('Product id is: ${resultText.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}');
      });
    }

    void onRecognitionComplete() {
      setState(() {
        _isListening = false;
        //   _handleSubmitted(resultText);
      });
    }

    _speechRecognition.setRecognitionResultHandler(onRecognitionResult);
    _speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);
  }

/*
    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => {resultText = speech,

            }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
            () {
                  (String speech) => setState(() => {resultText = speech,

              });
              print("line 79");
              print(resultText);
              setState(() => _isListening = false);

              */
/* print('-->setRecognitionCompleteHandler<--')
;              log(resultText);
                     setState(() {
                       completeResultText = resultText;
                       searchkeyword=resultText;
                     });*/ /*


            }
    );
*/

  // _speechRecognition.activate().then(
  //       (result) => setState(() => _isAvailable = result),
  // );

  /* @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isInit) {
      Provider.of<Products>(context).FetchandSetProducts(searchkeyword);
    }
    _isInit=false;
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    final _productlist = Provider.of<Products>(context);
    //final _productdata = _productlist.items;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Products'),
        actions: <Widget>[
          // PopupMenuButton(
          //   onSelected: (FilterOptions selectedValue) {
          //     setState(() {
          //       if (selectedValue == FilterOptions.Favorites) {
          //         _showOnlyFavorites = true;
          //       } else {
          //         _showOnlyFavorites = false;
          //       }
          //     });
          //   },
          //   icon: Icon(
          //     Icons.more_vert,
          //   ),
          //   itemBuilder: (_) => [
          //     PopupMenuItem(
          //       child: Text('Only Favorites'),
          //       value: FilterOptions.Favorites,
          //     ),
          //     PopupMenuItem(
          //       child: Text('Show All'),
          //       value: FilterOptions.All,
          //     ),
          //   ],
          // ),
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
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _search,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Search your item",
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            onChanged: (value) {},
          ),
          /*Container(
            width: MediaQuery.of(context).size.width *0.9 ,
            height:  MediaQuery.of(context).size.width *0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.black, width: 0.7),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,

              horizontal: 12.0,
            ),
            child: Text(
              resultText,
              textAlign:TextAlign.center,
              style: TextStyle(fontSize: 24.0),
            ),
          ),*/
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    child: FlatButton(
                      // padding: EdgeInsets.all(15),
                      child: Text(
                        'clear textfield',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                      ),
                      onPressed: () {
                        setState(() {
                          _search.text = "";
                          // completeResultText='';
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: FlatButton(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Voice Input',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      onPressed: () {
                        if (!_isListening)
                          _speechRecognition.listen(
                              locale:
                                  "en_US"); //.then((result) => resultText=result);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: FlatButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              ProgressDialog(status: 'Loading...'),
                        );
                        Provider.of<Products>(context, listen: false)
                            .FetchandSetProducts(_search.text);
                        Navigator.of(context)
                            .pushNamed(ProductScreen.routeName);
                        //initDialog();
                      },
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'search',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Categories",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(3),
            children: [
              Card(
                elevation: 2.0,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.phone),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Phone"),
                  onTap: () {
                    Provider.of<Products>(context, listen: false)
                        .FetchandSetProducts("Phone");
                    Navigator.of(context).pushNamed(Phone.routename);
                  },
                ),
              ),
              Card(
                elevation: 2.0,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.shoppingBag),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Bag"),
                  onTap: () {
                    Provider.of<Products>(context, listen: false)
                        .FetchandSetProducts("Bag");
                    Navigator.of(context).pushNamed(Bag.routename);
                  },
                ),
              ),
              Card(
                elevation: 2.0,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.stopwatch),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Watch"),
                  onTap: () {
                    Provider.of<Products>(context, listen: false)
                        .FetchandSetProducts("Watch");
                    Navigator.of(context).pushNamed(Watch.routename);
                  },
                ),
              ),
              Card(
                elevation: 2.0,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.shoePrints),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Shoes"),
                  onTap: () {
                    Provider.of<Products>(context, listen: false)
                        .FetchandSetProducts("Shoes");
                    Navigator.of(context).pushNamed(Shoe.routename);
                  },
                ),
              ),
              Card(
                elevation: 2.0,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.laptop),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Laptop"),
                  onTap: () {
                    Provider.of<Products>(context, listen: false)
                        .FetchandSetProducts("Laptop");
                    Navigator.of(context).pushNamed(Laptop.routename);
                  },
                ),
              ),
            ],

            /*  children: <Widget>[

              Container(
               height: MediaQuery.of(context).size.height*0.06,
               width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text("Phone", textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),



              SizedBox(
                height: 20,
              ),


              Container(
                height: MediaQuery.of(context).size.height*0.06,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text("laptops", textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),



              SizedBox(
                height: 20,
              ),




              Container(
                height: MediaQuery.of(context).size.height*0.06,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text("Bags", textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),


              SizedBox(
                height: 20,
              ),




              Container(
                height: MediaQuery.of(context).size.height*0.06,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text("Watches", textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),


              SizedBox(
                height: 20,
              ),




              Container(
                height: MediaQuery.of(context).size.height*0.06,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text("Shoes", textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),

            ],*/
          ),

          /*Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: Productlist(),
          ),*/
        ]),
      ),
    );
  }
  /*void initDialog() {
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

  /*Future<void> _submit() async{

        await Provider.of<Products>(context,listen: false).FetchandSetProducts(searchkeyword);

  }
*/
}


/**/
