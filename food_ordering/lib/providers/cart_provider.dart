import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final int price;
  int quantity;

  CartItem({required this.id, required this.name, required this.price, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get totalAmount {
    var total = 0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addItem(String id, String name, int price) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity += 1; // Increase quantity if already exists
    } else {
      _items.putIfAbsent(id, () => CartItem(id: id, name: name, price: price));
    }
    notifyListeners(); // Update the UI instantly
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}