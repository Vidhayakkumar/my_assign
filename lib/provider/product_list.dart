import 'package:flutter/material.dart';
import '../model/product_List_model.dart';
import '../services/aurhService.dart';


class ProductListProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  List<ProductListModel> _productList = [];
  bool _isLoading = false;
  String? _error;

  List<ProductListModel> get productList => _productList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserData(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _productList = await _authService.fetchUserData(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
