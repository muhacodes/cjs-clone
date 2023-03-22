import 'package:flutter/material.dart';
import 'package:restaurant_app/model/productModel.dart';
class Order {
  final menuItem item;
  final String? productTitle;
  final int quantity;
  final int total;
  final String name;
  final String email;
  final String address;
  Map<String, List<Options>>? choices;

  Order({
    required this.item,
    required this.quantity,
    required this.total,
    required this.name,
    required this.email,
    required this.address,
    this.choices,
    this.productTitle,
  });

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'quantity': quantity,
      'total': total,
      'name': name,
      'email': email,
      'address': address,
      'choices' : choices,
    };
  }
}
