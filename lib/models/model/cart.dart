import 'dart:collection';


import 'package:exam/models/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartProvider extends ChangeNotifier {
  final List<Products> _itemsInCart = [];

  UnmodifiableListView<Products> get itemsInCart =>
      UnmodifiableListView(_itemsInCart);

  double get totalCost {
    double price = 0;
    for (Products item in _itemsInCart) {
      price += item.price;
    }

    return price;
  }

  List<Products> get uniqueItems {
    final List<Products> unique = [];
    for (Products item in _itemsInCart) {
      if (!unique.contains(item)) {
        unique.add(item);
      }
    }
    return unique;
  }

  void add(Products item) {
    _itemsInCart.add(item);
    notifyListeners();
  }

  void emptyCart() {
    itemsInCart.clear();
    notifyListeners();
  }

}

// class CartProvider extends ChangeNotifier {
//
//   List<Products> lst = [];
//
//   add(String title, String price, String id){
//     lst.add(Products(
//       id: int.parse(id),
//       title: title,
//       price: price,
//     ));
//     notifyListeners();
//   }
//
//   Map<String, CartItem> _items = {};
//
//   Map<String, CartItem> get items {
//     return {..._items};
//   }
//
//   int get itemCount {
//     return _items.length;
//   }
//
//   double get totalAmount {
//     var total = 0.0;
//     _items.forEach((key, cartItem) {
//       total += cartItem.price! * cartItem.quantity!;
//     });
//     return total;
//   }
//
//   void addItem(String productId, int price, String title) {
//     if (_items.containsKey(productId)) {
//       // change quantity
//       _items.update(
//           productId,
//           (existingCartItem) => CartItem(
//                 id: existingCartItem.id,
//                 title: existingCartItem.title,
//                 price: existingCartItem.price,
//                 quantity: existingCartItem.quantity! + 1,
//               ));
//     } else {
//       _items.putIfAbsent(
//         productId,
//         () => CartItem(
//           id: DateTime.now().toString(),
//           title: title,
//           price: price,
//           quantity: 1,
//         ),
//       );
//     }
//     notifyListeners();
//   }
//
//   void removeItem(String productId) {
//     _items.remove(productId);
//     notifyListeners();
//   }
//
//   void removeSingleItem(String productId) {
//     if (!_items.containsKey(productId)) {
//       return;
//     }
//     if (_items[productId]!.quantity! > 1) {
//       _items.update(
//           productId,
//           (existingCartItem) => CartItem(
//               title: existingCartItem.title,
//               price: existingCartItem.price,
//               id: existingCartItem.id,
//               quantity: existingCartItem.quantity! - 1));
//     } else {
//       _items.remove(productId);
//     }
//     notifyListeners();
//   }
//
//   void clear() {
//     _items = {};
//     notifyListeners();
//   }
// }
