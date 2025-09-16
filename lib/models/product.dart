import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final double rating;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.description,
  });
}
