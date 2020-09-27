import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchProducts() async {
    const url = 'https://flutter-http-d88aa.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
          title: prodData['title'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-http-d88aa.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url = 'https://flutter-http-d88aa.firebaseio.com/products/$id.json';
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'price': newProduct.price,
              'imageUrl': newProduct.imageUrl,
            }));
      } catch (error) {
        throw error;
      }
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-http-d88aa.firebaseio.com//products/$id.json';
    final existingId = _items.indexWhere((item) => item.id == id);
    var existingProduct = _items[existingId];
    _items.removeAt(existingId);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingId, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
