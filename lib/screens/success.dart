import 'package:flutter/material.dart';
import 'package:restaurant_app/utils.dart';

class SuccessScreen extends StatelessWidget {
  static const routeName = 'success-screen';
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Order Places Succesfully', style: Global.kPrimaryLabel,),
      ),

      body: const Center(
        child: Text('Your order has been Placed succesfully!', style: Global.kPrimaryLabel,),
      ),
    );
  }
}
