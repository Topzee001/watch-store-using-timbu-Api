import 'package:flutter/material.dart';
import '../model/watch.dart';
import '../services/watch_service.dart';

class CartProvider with ChangeNotifier {
  List<Watch> _products = [];
  List<Watch> _cartItems = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Watch> get products => _products;
  List<Watch> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWatches() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ApiService().fetchWatches();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Watch product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Watch product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }

  // double get totalPrice {
  //   return _cartItems.fold(0, (sum, item) => sum + item.price);
  // }
}
