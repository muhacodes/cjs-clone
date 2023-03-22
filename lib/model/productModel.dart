class Category {
  String? id;
  String? imgUrl;
  String? title;
  String? description;

  Category({this.id, this.title, this.imgUrl, this.description});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imgUrl'] = this.imgUrl;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Menu {
  String? id;
  String? categoryId;
  String? title;
  String? imgUrl;
  String? description;
  Menu({this.id, this.categoryId, this.title, this.imgUrl, this.description});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['description'] = this.description;
    return data;
  }
}

class menuItem {
  String? id;
  String? menuId;
  String? title;
  String? imageUrl;
  String? description;
  int? price;
  Map<String, List<Options>>? choices;
  List<addOns>? addOn;

  menuItem({
    this.id,
    this.menuId,
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.choices,
    this.addOn,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menuId'] = this.menuId;
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['price'] = this.price;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((key, value) => MapEntry(key, value.map((option) => option.toJson()).toList()));
    }
    if (this.addOn != null) {
      data['addOn'] = this.addOn!.map((addOn) => addOn.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? id;
  String? choiceId;
  String? title;
  int? amount;

  Options({this.id, this.choiceId, this.amount, this.title});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['choiceId'] = this.choiceId;
    data['title'] = this.title;
    data['amount'] = this.amount;
    return data;
  }
}

class addOns {
  String id;
  String addOn;
  String price;

  addOns({required this.id, required this.addOn, required this.price});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['addOn'] = this.addOn;
    data['price'] = this.price;
    return data;
  }
}



// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
//
//
// class Category{
//   String? id;
//   String? imgUrl;
//   String? title;
//   String? description;
//
//   Category({this.id, this.title, this.imgUrl, this.description});
// }
//
// class Menu{
//   String? id;
//   String? categoryId;
//   String? title;
//   String? imgUrl;
//   String? description;
//   Menu({this.id, this.categoryId, this.title, this.imgUrl, this.description});
//
// }
//
// class menuItem{
//   String? id;
//   String? menuId;
//   String? title;
//   String? imageUrl;
//   String? description;
//   int? price;
//   Map<String, List<Options>>? choices;
//   List<addOns>? addOn;
//
//   menuItem({
//     this.id,
//     this.menuId,
//     this.title,
//     this.description,
//     this.imageUrl,
//     this.price,
//     this.choices,
//     this.addOn,
//   });
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['menuId'] = this.menuId;
//     data['title'] = this.title;
//     data['imageUrl'] = this.imageUrl;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     if (this.choices != null) {
//       data['choices'] = this.choices!.map((key, value) => MapEntry(key, value.map((option) => option.toJson()).toList()));
//     }
//     if (this.addOn != null) {
//       data['addOn'] = this.addOn!.map((addOn) => addOn.toJson()).toList();
//     }
//     return data;
//   }
//
// }
//
// class Options{
//   String? id;
//   String? choiceId;
//   String? title;
//   int? amount;
//   Options({this.id, this.choiceId, this.amount, this.title});
// }
//
// class addOns{
//   String id;
//   String addOn;
//   String price;
//
//   addOns({required this.id, required this.addOn, required this.price});
// }
//
