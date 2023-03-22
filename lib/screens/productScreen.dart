import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/cartModel.dart';
import 'package:restaurant_app/providers/cartProvider.dart';
import 'package:restaurant_app/utils.dart';

import '../model/productModel.dart';
import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = 'product';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // final Set<Options> selectedOptions = {};
  final Map<String, Options?> selectedOptions = {};
  bool _showTitle = false;


  @override
  Widget build(BuildContext context) {
    final menu = ModalRoute.of(context)?.settings.arguments as menuItem;
    final cartprovider = context.read<Cart>();

    Map<String, List<Options>> ChoicesSelected = {};
    void addCart(){
      // print(selectedOptions);
      if(selectedOptions.length == menu.choices!.length){
        int totalamount = menu.price!;
        for(var item in selectedOptions.entries){
          totalamount += item.value!.amount ?? 0;

          final List<Options> currentSelectedOptions = [];
          currentSelectedOptions.add(Options(
            amount: item.value!.amount,
            choiceId: item.value!.choiceId,
            id: item.value!.id,
            title: item.value!.title,
          ));
          ChoicesSelected[item.key] = currentSelectedOptions;
        }
        cartprovider.addItem(
          item: menu,
          title: menu.title.toString(),
          id: menu.id.toString(),
          price: double.parse(totalamount.toString()),
          choices: ChoicesSelected,
        );
        Navigator.pushReplacementNamed(context, CartScreen.routeName);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('Your message here'),
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          ),
        );
        print('Please choose the options!');
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              // titlePadding:
              // const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              title: Text(
                menu.title.toString(),
                style: Global.kPrimaryText.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w900
                  // backgroundColor: Colors.grey
                ),
              ),
              background: Image.network(menu.imageUrl.toString(),
                  fit: BoxFit.fitHeight),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                SizedBox(
                  height: 340,
                  child: ListView(
                    children: menu.choices!.entries
                        .map(
                          (e) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: ListTile(
                            title: Container(
                              width: 30,
                              // height: 50,
                              // color: Colors.yellowAccent,
                              child: Text(
                                e.key,
                                style: Global.kPrimaryText.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            trailing: SizedBox(
                              width: 220,
                              child: DropdownButton<Options>(
                                onChanged: (Options? value) {
                                  setState(() {
                                    selectedOptions[e.key] = value;
                                  });
                                },
                                items: e.value.map((e) => DropdownMenuItem<Options>(
                                  // alignment: Alignment.bottomRight,
                                  value: e,
                                  child: Text(
                                    // 'amoney',
                                    e.amount is int ? ' ${e.title} - ${e.amount}' : '${e.title}',
                                    // e.amount is int ? "${e.title} - 55 UGX" : '${e.title}',
                                    //   e.amount !=  null ? "${e.title} - ${e.amount} UGX" : '${e.title}',
                                    // e.title.toString(),
                                    style: Global.kPrimaryText.copyWith(fontSize: 10, color: Colors.grey,
                                      fontWeight: FontWeight.w900
                                    ),
                                  ),
                                )).toList(),
                                value: selectedOptions[e.key],
                              )
                            ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),

                Spacer(),

                Container(
                  color: Colors.black,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: addCart,
                    label: Text('Add to Cart', style: Global.kPrimaryText.copyWith(color: Colors.white, fontSize: 18),),
                    // child: Text('Add to Cart', style: Global.kPrimaryText.copyWith(color: Colors.white, fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}