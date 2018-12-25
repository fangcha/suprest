import 'package:flutter/material.dart';

class Product {
  final String id;
  final String sku;
  final String name;
  final int price;
  final int stock;
  final int quantity;

  Product(
      {@required this.id,
      @required this.sku,
      @required this.name,
      @required this.price,
      @required this.quantity,
      @required this.stock});
}
