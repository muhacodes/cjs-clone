import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:restaurant_app/services/product_services.dart';
import '../model/productModel.dart';

class MenuProvider with ChangeNotifier{
  final _service = ProductServices();
  List<Menu> _menu = [];

  List<Menu> get items{
    return [..._menu];
  }

  List<Menu> findByIdCategory(String id) {
    return _menu.where((menu) => menu.categoryId == id).toList();
  }


  Future<void> fetch() async{
    _menu = await _service.getMenu();
    notifyListeners();
  }


}