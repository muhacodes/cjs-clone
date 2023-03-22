import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/providers/categoryProvider.dart';
import 'package:restaurant_app/providers/menuProvider.dart';
import 'package:restaurant_app/providers/productProvider.dart';
import 'package:restaurant_app/screens/home_search.dart';
import 'package:restaurant_app/screens/menuScreen.dart';
import 'package:restaurant_app/screens/testing.dart';
import 'package:restaurant_app/screens/widget/category_list.dart';
import 'package:restaurant_app/screens/widget/product_item.dart';
import 'package:restaurant_app/services/product_services.dart';
import '../model/productModel.dart';
import '../utils.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // things to deal with the seachbar

  final _service = ProductServices();
  bool loading = false;


  var is_init = true;


  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async{
    await context.read<CategoryProvider>().fetch();
    // Provider.of<CategoryProvider>(context).fetch();
    await context.read<MenuProvider>().fetch();

    await context.read<ProductProvider>().fetch();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu_outlined),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delicious Meals for \n you',
                style: Global.kPrimaryHeadline,

              ),
              const SizedBox(
                height: 35,
              ),

              _SearchBar(),

              const SizedBox(
                height: 20,
              ),

              const CategoryList(),

              const SizedBox(
                height: 30,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  _SearchBar({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onSubmitted: (val) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchProduct(query: _textController.text),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
