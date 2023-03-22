import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/productModel.dart';
import 'package:restaurant_app/providers/cartProvider.dart';
import 'package:restaurant_app/providers/productProvider.dart';
import 'package:restaurant_app/screens/productScreen.dart';
import 'package:restaurant_app/utils.dart';

class SearchProduct extends StatefulWidget {
  static const routeName = 'search-product';
  String query;
  SearchProduct({Key? key, required this.query}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.query),
      ),

      body: Consumer<ProductProvider>(
        builder: (ctx, provider, _) {
          final searchedProduct = provider.items;
          print(searchedProduct);
          if(searchedProduct.isEmpty){
            return Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Whoops, OHH NO', style: Global.kPrimaryLabel.copyWith(
                      fontSize: 32,
                      color: Colors.deepOrange,
                    ),
                      textAlign: TextAlign.start,
                    ),

                    Text('we are sorry we  \n don\'t have the product \n you looking for ', style: Global.kPrimaryLabel.copyWith(
                      fontSize: 23
                    ),
                      textAlign: TextAlign.start,
                    )
                  ],
                )
              ),
            );
          }
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 6/7,
            ),

            children: searchedProduct.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: e);
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
                                  image: NetworkImage(e.imageUrl.toString()),
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
                            Container(
                              width: 190,
                              // color: Colors.red,
                              // height: 20,
                              child: Text(
                                e.title.toString(),
                                style: Global.kPrimaryText.copyWith(
                                    color: Colors.white, fontSize: 12
                                ),
                                overflow: TextOverflow.ellipsis,
                                // overflow: TextOverflow.fade,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${e.price.toString()} GBP',
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


class _ProductItem extends StatelessWidget {
  final menuItem products;
  const _ProductItem({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5/6,
        crossAxisSpacing: 5,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (ctx, index) {
        // final item = products[index]
        return GestureDetector(
          onTap: (){
            // Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: item);
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
                          image: NetworkImage(products.imageUrl.toString()),
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
                      '',
                      style: Global.kPrimaryText.copyWith(
                          color: Colors.white, fontSize: 12
                      ),
                      // overflow: TextOverflow.fade,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '',
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
    );
  }
}
