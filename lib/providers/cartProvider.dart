import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/model/cartModel.dart';
import 'package:restaurant_app/model/productModel.dart';

class Info{
  String name;
  String address;
  String number;
  String email;
  Info({required this.name, required this.address, required this.email, required this.number});
}
class Cart with ChangeNotifier {
  List<CartItem> _item = [];

  List<CartItem> get items{
    return [..._item];
  }

  int get itemCount {
    return _item.length;
  }

  Map information = {};

  void addInfo(Map info){
    information = info;
    notifyListeners();
  }



  void addItem({required Map<String, List<Options>> choices,required String id, required double price, required String title, required menuItem item}){

    final existingItem = _item.any((item) => item.id == id);
    if (existingItem) {
      final product = _item.firstWhere((element) => element.id == id);
      product.quantity += 1;
    } else {
      _item.add(
          CartItem(
            id: id,
            title: title,
            totalAmount: price,
            item: item,
            quantity: 1,
            price: item.price,
            choices: choices
          )
      );
    }

    notifyListeners();
    // print(_item);
  }

  void quantity({required String productId, required bool add}){
    if(add){
      final cartItem = _item.firstWhere((element) => element.id == productId);
      if(cartItem.quantity < 10){
        cartItem.quantity+=1;
        final total = cartItem.quantity * cartItem.price!;
        cartItem.totalAmount = total.toDouble();
        notifyListeners();
      }
    }else{
      final cartItem = _item.firstWhere((element) => element.id == productId);
      if(cartItem.quantity >= 2){
        cartItem.quantity-=1;
        final total = cartItem.quantity * cartItem.price!;
        cartItem.totalAmount = total.toDouble();
        notifyListeners();
      }
    }

    notifyListeners();
  }

  void Clear(){
    _item = [];
    notifyListeners();
  }

  void removeItem(String id){
    _item.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  double calculateTotalAmount(){
    double  totalAmount = 0;
    for(var item in _item){
      // totalAmount+= item.totalAmount * item.quantity;
      totalAmount+= item.totalAmount;
    }
    return totalAmount;
  }


}