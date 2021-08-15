import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String discription;
  final String imageurl;
  final String price;
  bool isfavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.discription,
    @required this.imageurl,
    @required this.price,
    this.isfavorite = false  });
  void toggleFavoriteStatus() {
    isfavorite = !isfavorite;
    notifyListeners();
  }
}
