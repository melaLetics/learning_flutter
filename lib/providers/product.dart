import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    var oldStatus = isFavorite;
    final url = 'https://flutter-http-d88aa.firebaseio.com//products/$id.json';
    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.patch(url,
        body: json.encode(
          {
            'isFavorite': isFavorite,
          },
        ));
    if (response.statusCode >= 400) {
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpException('Updating product was not succesful!');
    }
    oldStatus = false;
  }
}
