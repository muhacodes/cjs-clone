import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/checkout_screen.dart';
import '../providers/cartProvider.dart';
import '../utils.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void CartQuantity({required String productId, required bool action}){
    // The action boolean method checks if its increamentin the quantity of decreaminting the quantity
    context.read<Cart>().quantity(productId: productId, add: action);
    calculateCartTotalAmount();
  }

  bool isInit = true;
  double totalAmount = 0;
  @override
  void initState() {
    print('chanfed');
    // TODO: implement initState
    // calculateCartTotalAmount();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    print('did change depe');
    // TODO: implement didChangeDependencies
    calculateCartTotalAmount();
    super.didChangeDependencies();
  }

  void calculateCartTotalAmount(){
    totalAmount = context.read<Cart>().calculateTotalAmount();
  }

  remoteCartItem(String id){
    context.read<Cart>().removeItem(id);
    // setState(() {
    //
    // });
  }
  remoteItem(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.transparent,
      ),

      body: Consumer<Cart>(builder: (ctx, provider, _) =>
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: provider.itemCount,
                itemBuilder: (ctx, index) {
                  final product = provider.items[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.delete, size: 32, color: Colors.red),
                      ),
                      onDismissed: (_){
                        remoteCartItem(product.id);
                      },

                      key: Key(provider.items[index].id),
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.red,
                          ),
                          child: Image.network(product.item.imageUrl.toString(), fit: BoxFit.fitHeight),
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              // color: Colors.red,
                              child: Text(
                                product.title.toString(),
                                style: Global.kPrimaryText.copyWith(
                                    fontSize: 16,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 20,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Quantity', style: Global.kPrimaryLabel,),
                                const SizedBox(width: 20,),
                                Text(product.quantity.toString(), style: Global.kPrimaryLabel,),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Price', style: Global.kPrimaryLabel,),
                                const SizedBox(width: 20,),
                                Text(product.item.price.toString(), style: Global.kPrimaryLabel,),
                              ],
                            ),

                            Row(children: [
                              IconButton(
                                onPressed: (){
                                  CartQuantity(productId: product.id, action: true);
                                },
                                icon: const Icon(Icons.add,),
                                color: Colors.grey,
                              ),

                              const SizedBox(width: 5,),
                              IconButton(
                                onPressed: (){
                                  CartQuantity(action: false, productId: product.id);
                                },
                                icon: const Icon(Icons.remove,),
                                color: Colors.grey,
                              )
                            ],)
                          ],
                        )
                      ],
                  ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 90,
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  TextButton(
                    onPressed: (){},
                    child:  Text('Total Amount', style: Global.kPrimaryLabel.copyWith(fontSize: 14, color: Colors.black),),
                    style:  ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Text('$totalAmount', style: Global.kPrimaryLabel.copyWith(fontSize: 13),),
                  const Spacer(),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, CheckOutScreen.routeName);
                        // calculateCartTotalAmount();
                      },
                      icon: const Icon(Icons.arrow_left, size: 25,),
                      label: Text('Checkout', style: Global.kPrimaryLabel.copyWith(color: Colors.black),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
