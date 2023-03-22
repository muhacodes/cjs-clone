import 'package:flutter/material.dart';
import 'package:restaurant_app/model/productModel.dart';
import 'package:restaurant_app/providers/menuProvider.dart';
import 'package:restaurant_app/screens/cart_screen.dart';
import 'package:restaurant_app/screens/productScreen.dart';
import 'package:restaurant_app/utils.dart';
import 'package:provider/provider.dart';

import '../providers/categoryProvider.dart';
import '../providers/productProvider.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = 'menu-screen';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final menu = ModalRoute.of(context)?.settings.arguments as Menu;
    // final products = context.read<ProductProvider>().items;
    final products = context.read<ProductProvider>().findByIdCategory(menu.id.toString());

    // final products = Provider.of<ProductProvider>(context, listen: false).findByIdCategory(menu.id.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(menu.title.toString()),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5/6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (ctx, index) {
            final item = products[index];
            print(item.choices?.length);
            return GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: item);
              },
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -4,
                    left: 40,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: Image(
                              height: 110,
                              width: 100,
                              image: NetworkImage(item.imageUrl.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.title.toString(),
                          style: Global.kPrimaryText.copyWith(
                              color: Colors.white, fontSize: 12
                          ),
                          // overflow: TextOverflow.fade,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${item.price.toString()} GBP',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
