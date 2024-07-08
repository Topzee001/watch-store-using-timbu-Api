import 'package:flutter/material.dart';
import '../model/product.dart';
import '../services/watch_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _cart = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  List<Product> get cart => _cart;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ApiService().fetchProducts();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _cart.fold(0, (sum, item) => sum + item.price);
  }
}
