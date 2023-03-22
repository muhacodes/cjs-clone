import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/cartModel.dart';
import 'package:restaurant_app/model/order.dart';
import '../model/productModel.dart';

class ProductServices{

  static const ip = 'http://10.43.202.250:2000';

    Future<List<Category>> getCategory() async{
      // var url = Uri.parse('https://ukashshop-d6c1b-default-rtdb.asia-southeast1.firebasedatabase.app/orders/');
      // const url = 'http://172.20.10.7:2000/api/category';
      const url = '$ip/api/category';
      //172.20.10.7:2000
      final res = await http.get(Uri.parse(url));
      List<Category> _category = [];
      final data = jsonDecode(res.body);
      for(var item in data){
        _category.add(Category(
          id: item['id'].toString(),
          title: item['title'],
          description: item['description'],
          imgUrl: item['imgUrl']
        ));
      }

      return _category;
    }


    Future<List<Menu>> getMenu() async{
      // var url = Uri.parse('https://ukashshop-d6c1b-default-rtdb.asia-southeast1.firebasedatabase.app/orders/');
      // const url = 'http://172.20.10.7:2000/api/menu';
      const url = '$ip/api/menu';
      //172.20.10.7:2000
      final res = await http.get(Uri.parse(url));
      List<Menu> _menu = [];
      final data = jsonDecode(res.body);
      for(var item in data){

        _menu.add(Menu(
          id: item['id'].toString(),
          title: item['title'],
          description: item['description'],
          imgUrl: item['imgUrl'],
          categoryId: item['categoryId'].toString()
        ));
      }
      return _menu;
    }

    Future<void> postOrder(List<CartItem> cart,inf)async {

      print(inf['Name']);
      Map<String, List<Options>> selectedChoice = {};
      // print(cart.last.choices);
      for(var item in cart){
        if(item.choices != null){
          for(var choice in item.choices!.entries){
            List<Options> loadedOptions = [];
            loadedOptions.add(
              Options(
                id: choice.value.first.id,
                title: choice.value.first.title,
                choiceId: choice.value.first.choiceId,
                amount: choice.value.first.amount,
              )
            );
            selectedChoice[choice.key] = loadedOptions;

            // selectedChoice[choice.key] = [Options(
            //   id: choice.value.first.id,
            //   title: choice.value.first.title,
            //   choiceId: choice.value.first.choiceId,
            //   amount: choice.value.first.amount,
            // )];
            // print(choice.key);
            // print(choice.value.first.title);
          }
        }
      }

      // print(selectedChoice);
      final List<Order> order = [];
      for(var item in cart){

        order.add(Order(
          choices: selectedChoice,
          item: item.item,
          quantity: item.quantity,
          address: inf['address'],
          email: inf['email'],
          name: inf['name'],
          total: item.totalAmount.toInt()
        ));
      }

      final List<Map<String, dynamic>> orderJson = order.map((o) => o.toJson()).toList();


      // const url = 'http://172.20.10.7:2000/api/orders';

      const url = '$ip/api/orders';
      final body = {
        "Name": "mohammed",
        "myItems": [1,2],
        "category" : [1,2],
        "order" : orderJson,
      };

      final res = await http.post(
          Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
    }

    Future<List<menuItem>> getProducts() async{
      // const url = 'http://172.20.10.7:2000/api/menu-item';
      const url = '$ip/api/menu-item';
      final res = await http.get(
        Uri.parse(url),
      );
      final data = jsonDecode(res.body);
      final List<menuItem> loadedItem = [];

      print(data.toString());
      for(var item in data){
        Map<String, List<Options>>? choices = {};
        List<dynamic>? choicesData = item['choices'];
        if (choicesData != null) {
          for (var choice in choicesData) {
            String? name = choice['name'];
            // print(choice);
            print(choice['id']);
            List<dynamic>? optionsData = choice['options'];
            if (name != null && optionsData != null) {
              List<Options> options = [];
              for (var option in optionsData) {
                // print(option);
                // print(option['amount']);
                options.add(Options(
                  id: option['id'].toString(),
                  choiceId: choice['id'].toString(),
                  title: option['option'],
                  amount: option['amount'],
                ));
              }
              choices[name] = options;
            }
          }
        }
        // print(choices);
        // print(item);
        loadedItem.add(menuItem(
          id: item['id'].toString(),
          title: item['title'],
          price: item['price'],
          description: item['description'],
          menuId: item['menu_id'].toString(),
          imageUrl: item['image_url'],
          choices: choices
        ));

      }


      return loadedItem;
    }
}