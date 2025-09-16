import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String size;
  final Color color;

  CartItem({
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });
}