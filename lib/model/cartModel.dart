import 'productModel.dart';
import 'productModel.dart';
class CartItem {
  String id;
  String title;
  menuItem item;
  double totalAmount;
  int quantity;
  int? price;
  String? menuId;
  Map<String, List<Options>>? choices;

  CartItem({
    required this.id,
    required this.title,
    required this.totalAmount,
    required this.item,
    required this.quantity,
    this.choices,
    this.price,
    this.menuId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['item'] = item.toJson();
    data['totalAmount'] = totalAmount;
    data['quantity'] = quantity;
    return data;
  }
}
