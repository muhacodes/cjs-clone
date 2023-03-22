import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/productModel.dart';
import '../../providers/categoryProvider.dart';
import '../../providers/menuProvider.dart';
import '../../utils.dart';
import '../menuScreen.dart';
class ProductItem extends StatelessWidget {
  final String productId;
  const ProductItem({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final List<Menu> _menu =
    //     Provider.of<MenuProvider>(context, listen: false).findByIdCategory(productId);

    final List<Menu> _menu = context.read<MenuProvider>().findByIdCategory(productId);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 270,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(right: 30),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _menu.length,
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, MenuScreen.routeName, arguments: _menu[index]);
              },
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 20),
                    width: 230,
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
                    top: -10,
                    left: 20,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image(
                            height: 170,
                            width: 180,
                            image: NetworkImage(_menu[index].imgUrl.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          _menu[index].title.toString(),
                          style: Global.kPrimaryText.copyWith(
                              color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //  Text(
                        //   _menu[index].id.toString(),
                        //   style: const TextStyle(
                        //       color: Colors.white, fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
