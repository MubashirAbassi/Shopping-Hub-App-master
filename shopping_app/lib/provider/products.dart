import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/provider/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    /* Product(
        id: '1',
        title: 'Yellow Scarf',
        discription: 'this is an imported product',
        imageurl:
            'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
        price: 29.12,

    ),
    Product(
        id: '2',
        title: 'A Pan',
        discription: 'Prepare any meal you want.',
        imageurl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
        price: 49.99,
     ),

    Product(
        id: '3',
        title: 'Red Shirt',
        discription: 'this is an imported product',
        imageurl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        price: 12.5,
      )*/
  ];

  Future<void> FetchandSetProducts(String keyword) async {
    itemscleared();
    final url =
        "https://amazon24.p.rapidapi.com/api/product?country=US&keyword=$keyword";
    //final url2="https://ali-express1.p.rapidapi.com/search?query=bag";
    try {
      final response = await http.get(url, headers: {
        "x-rapidapi-key": "8f7dd0349amshde6d6bb3893598cp14ee64jsn6b103731d8e7"
      });
      // final response2 =await http.get(url2,headers: {"x-rapidapi-key": "8f7dd0349amshde6d6bb3893598cp14ee64jsn6b103731d8e7"});
      // print(json.decode(response2.body));     // print('another data: ${(Map<dynamic, dynamic>.from(json.decode(response2.body)))}');
      var ectractdata =
          (Map<dynamic, dynamic>.from(json.decode(response.body)));
      print(ectractdata);
      final List<Product> LoadedProducts = [];
      List data = (ectractdata['docs']);
      data.forEach((element) {
        if (element['product_title'] != null) {
          LoadedProducts.add(Product(
              id: element["product_id"],
              title: element["product_title"],
              imageurl: element["product_main_image_url"],
              price: element["app_sale_price"],
              discription: element["product_title"]));
        }
      });
      _items = LoadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Product> get items {
    return [..._items];
  }

  void itemscleared() {
    _items.clear();
    notifyListeners();
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isfavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) {
    const url = '';
    final newProduct = Product(
      title: product.title,
      discription: product.discription,
      price: product.price,
      imageurl: product.imageurl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
