import 'package:flutter/material.dart';
import '../model/productModel.dart';
import '../services/product_services.dart';

class CategoryProvider with ChangeNotifier {
  final  _service = ProductServices();

  var categoryId = '105';
  List<Category> _category = [];

  List<Category> get items{
    return [..._category];
  }

  set category(List<Category> value) {
    _category = value;
    notifyListeners();
  }

  Future<void> fetch() async{
    _category  = await _service.getCategory();
    categoryId =  _category.first.id.toString();
    notifyListeners();
  }

  String getFirstCategory() {
    return categoryId;
  }
}
