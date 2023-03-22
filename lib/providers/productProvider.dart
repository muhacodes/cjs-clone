import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import '../services/product_services.dart';

import '../model/productModel.dart';

class ProductProvider with ChangeNotifier {
  List<menuItem> _product = [
    // menuItem(
    //   id: 'LOADED_CHAPATI_COMBO',
    //   imageUrl:
    //   'https://restaurentapp.s3.eu-west-1.amazonaws.com/productImages/1629089856.jpg',
    //   price: 31000,
    //   title: 'LOADED CHAPATI COMBO',
    //   menuId: 'BREAKFAST_COMBOS',
    //   choices: {
    //     "Choice of Eggs": [
    //       Options(
    //         title: 'Fried Eggs',
    //         choiceId: 'Choice of Eggs',
    //       ),
    //       Options(
    //         title: 'Boiled',
    //         choiceId: 'Choice of Eggs',
    //       ),
    //     ],
    //     "Choice of Juice": [
    //       Options(
    //         title: 'Passion',
    //         choiceId: 'Choice of Eggs',
    //       )
    //     ]
    //   },
    //   description:
    //   'Chapatti, fried spinach, 2 Sausages, 2 eggs served with Home fries and Baked Beans.',
    // ),
    //
    // menuItem(
    //   id: 'CARIBBEAN_JERK_CHICKEN_COMBO',
    //   imageUrl:
    //       'https://restaurentapp.s3.eu-west-1.amazonaws.com/productImages/1629089856.jpg',
    //   price: 51000,
    //   title: 'CARIBBEAN JERK CHICKEN COMBO',
    //   menuId: 'BIG_MEAL_COMBOS',
    //   choices: {
    //     "CHOOSE AN ACCOMPANIMENT": [
    //       Options(
    //         title: 'Chips',
    //       ),
    //       Options(
    //         title: 'Mexican Rice',
    //       ),
    //       Options(
    //         title: 'Steamed Rice',
    //       ),
    //       Options(title: 'Substitute Masala Chips', amount: 5000),
    //     ],
    //     "Choice of Juice": [
    //       Options(
    //         title: 'Passion',
    //       ),
    //       Options(
    //         title: 'Watermelon',
    //       ),
    //       Options(
    //         title: 'Passion',
    //       )
    //     ]
    //   },
    //   description:
    //       'Chapatti, fried spinach, 2 Sausages, 2 eggs served with Home fries and Baked Beans.',
    // )
  ];
  final  _service = ProductServices();

  final List<Options> _options = [
    // Options(
    //   id: 'Fried_Eggs',
    //   choiceId: 'Choice_of_Eggs',
    //   title: 'Fried Eggs',
    //   amount: null,
    // ),
    // Options(
    //   id: 'Scrambled',
    //   title: 'Scrambled',
    //   amount: null,
    // ),
    // Options(
    //   id: 'Boiled',
    //   title: 'Boiled',
    //   amount: null,
    // ),
    // Options(
    //   id: 'Passion',
    //   title: 'Passion',
    //   amount: null,
    // ),
    // Options(
    //   id: 'Watermelon',
    //   title: 'Watermelon',
    //   amount: null,
    // ),
    // Options(
    //   id: 'House_Coffee_White',
    //   title: 'House_Coffee_White',
    //   amount: null,
    // )
  ];

  set product(List<menuItem> value) {
    _product = value;
    notifyListeners();
  }

  List<menuItem> get items {
    return [..._product];
  }

  Future<void> fetch() async{
    _product  = await _service.getProducts();
  }
  menuItem getMenuItem(id) {
    return _product.firstWhere((product) => product.id == id);
  }

  List<menuItem> findByIdCategory(String id) {
    return _product.where((menu) => menu.menuId == id).toList();
  }

  List<menuItem> searchProduct(String search){
    return _product.where((element) => element.title!.toLowerCase().contains(search.toLowerCase())).toList();
  }
}
