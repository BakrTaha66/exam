import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartItem {
  String? id;
  String? title;
  double? price;
  int? quantity;

  CartItem({
    this.id,
    this.title,
    this.price,
    this.quantity
  });
}
class Cart extends ChangeNotifier{

Map<String, CartItem> _items = {};

Map<String, CartItem> get items {
return{..._items};
}

int get itemCount {
  return _items.length;
}

double get totalAmount {
  var total = 0.0;
  _items.forEach((key, cartItem){
    total += cartItem.price! * cartItem.quantity!;
  });
  return total;
}


void addItem(String productId, double price, String title) {
  if(_items.containsKey(productId)) {
    // change quantity
    _items.update(productId, (existingCartItem) => CartItem(
      id: existingCartItem.id,
      title: existingCartItem.title,
      price: existingCartItem.price,
      quantity: existingCartItem.quantity! + 1,));
  } else {
    _items.putIfAbsent(productId, () => CartItem(
      id: DateTime.now().toString(),
      title: title,
      price: price,
      quantity: 1,
    ),);
  }
  notifyListeners();
}

void removeItem(String productId){
  _items.remove(productId);
  notifyListeners();
}

void removeSingleItem(String productId){
  if (!_items.containsKey(productId)) {
    return;
  }
  if(_items[productId]!.quantity! > 1){
    _items.update(productId, (existingCartItem) => CartItem(
        title:  existingCartItem.title,
        price: existingCartItem.price,
        id: existingCartItem.id,
        quantity: existingCartItem.quantity! - 1
    ));
  }else {
    _items.remove(productId);
  }
  notifyListeners();
}

void clear(){
  _items = {};
  notifyListeners();
}
}