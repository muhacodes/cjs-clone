import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/cartProvider.dart';
import 'package:restaurant_app/screens/success.dart';
import 'package:restaurant_app/utils.dart';

import '../services/product_services.dart';

class ConfirmScreen extends StatefulWidget {
  static const routeName = 'confirm-screen';
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {

  bool isLoading = false;

  void submitForm() async{
    setState(() {
      isLoading  = true;
    });
    final _service =  ProductServices();
    final information = context.read<Cart>().information;
    final cart = context.read<Cart>().items;

    await _service.postOrder(cart, information);
    Navigator.of(context).pushReplacementNamed(SuccessScreen.routeName);
    // print(information.length);

  }
  @override
  Widget build(BuildContext context) {

    // print(context.read<Cart>().information);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Place Order', style: Global.kPrimaryLabel,),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Details!',
                style: Global.kPrimaryLabel.copyWith(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.w900
                ),
              ),
              const SizedBox(height: 30,),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                    width: 1
                  )
                ),
                child: Consumer<Cart>(
                  builder: (ctx, provider, _) =>  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Contact Information', style: Global.kPrimaryLabel.copyWith(fontWeight: FontWeight.w900),),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, color: Colors.blue,),
                            onPressed: (){},
                          ),
                        ],
                      ),
                      // Container(
                      //   child: IconButton(
                      //     icon: Icon(Icons.edit_outlined, color: Colors.blue,),
                      //     onPressed: (){},
                      //   ),
                      //   alignment: Alignment.topRight,
                      // ),
                      ListTile(
                        title: const Text('Name', style: Global.kPrimaryLabel,),
                        trailing: Text(provider.information['name'].toString(), style: Global.kPrimaryLabel,),
                      ),

                      ListTile(
                        title: const Text('Your Email',style: Global.kPrimaryLabel,),
                        trailing: Text(provider.information['email'].toString(), style: Global.kPrimaryLabel,),
                      ),

                      ListTile(
                        leading: const Text('Your Address', style: Global.kPrimaryLabel,),
                        trailing: Text(provider.information['address'].toString(), style: Global.kPrimaryLabel,),
                      ),

                      ListTile(
                        title: const Text('Your Number', style: Global.kPrimaryLabel,),
                        trailing: Text(provider.information['number'].toString(), style: Global.kPrimaryLabel,),
                      )
                    ],
                  ),
                )
              ),
              const SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white24,
                        width: 1
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Your Order!', style: Global.kPrimaryLabel.copyWith(fontWeight: FontWeight.w900),),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blue,),
                          onPressed: (){},
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Consumer<Cart>(
                      builder: (ctx, provider, _) => Container(
                        width: double.infinity,
                        height: 150,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.itemCount,
                          itemBuilder: (ctx, index){
                            final pro = provider.items[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.all(5),
                              leading: Container(
                                height: 40,
                                width: 40,
                                child: Image.network(
                                  provider.items[index].item.imageUrl.toString(),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text('Item', style: Global.kPrimaryLabel.copyWith(),),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: 170,
                                    height: 20,
                                    child: Text(pro.title.toString(), style: Global.kPrimaryLabel.copyWith(fontSize: 14), overflow: TextOverflow.ellipsis,),
                                  )
                                ],
                              ),
                              trailing: Text('Quantity : ${pro.quantity}', style: Global.kPrimaryLabel,)
                            );
                          },
                        ),
                      )
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.green,
        width: double.infinity,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.arrow_left_outlined, color: Colors.white,),
            label: isLoading  ? const CircularProgressIndicator() : Text('Place orders', style: Global.kPrimaryLabel.copyWith(color: Colors.black, fontSize: 18),),
            onPressed: submitForm,
          ),
        ),
      ),
    );
  }
}
