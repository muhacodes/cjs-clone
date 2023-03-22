import 'package:flutter/material.dart';
import 'package:restaurant_app/providers/cartProvider.dart';
import 'package:restaurant_app/screens/confirm_screen.dart';
import 'package:restaurant_app/utils.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = '/checkout';
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  void submitForm(){
    if(_formKey.currentState!.validate()){
      final myinfo = Info(
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
        number: phoneController.text
      );

      Map orderInformation = {
        'name' : nameController.text,
        'email' : emailController.text,
        'address' : addressController.text,
        'number' : phoneController.text,
      };


      context.read<Cart>().addInfo(orderInformation);
      Navigator.of(context).pushReplacementNamed(ConfirmScreen.routeName);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    // _formKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            // expandedHeight: 70,
            backgroundColor: Colors.transparent,
            // floating: true,
            flexibleSpace: FlexibleSpaceBar(
              // titlePadding:
              // const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              title: Text(
                'Checkout',
                style: Global.kPrimaryText.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  // backgroundColor: Colors.grey
                ),
              ),
              background: Text(
                'Checkout',
                style: Global.kPrimaryText.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w900
                  // backgroundColor: Colors.grey
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Text('Fill in the form to complete your order', style: Global.kPrimaryLabel,),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Form(
                 key: _formKey,
                 child: Column(
                   children: [
                     TextFormField(
                       controller: nameController,
                       style: const TextStyle(color: Colors.white70),
                       decoration:  const InputDecoration(
                         hintText: 'Your Name',
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.white12,
                             width: 2.0,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.white70,
                             width: 2.0,
                           ),
                         ),
                         icon: Icon(Icons.person_outline, color: Colors.blue,),
                         hintStyle: TextStyle(color: Colors.white24, fontSize: 14, fontWeight: FontWeight.w900)
                       ),
                       validator: (val){
                         if(val == null || val.length <= 5){
                           return 'please enter a valid value';
                         }
                       },
                     ),
                     const SizedBox(height: 50,),

                     TextFormField(
                       controller: emailController,
                       style: const TextStyle(color: Colors.white70),
                       decoration: const InputDecoration(
                         hintText: 'Your Email',
                         fillColor: Colors.red,
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.white12,
                             width: 2.0,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.white,
                             width: 2.0,
                           ),
                         ),
                         icon: Icon(Icons.email_outlined, color: Colors.blue),
                         hintStyle: TextStyle(color: Colors.white24, fontSize: 14, fontWeight: FontWeight.w900)
                       ),
                       validator: (val){
                         if(val == null || val.length <= 5){
                           return 'please enter a valid value';
                         }
                       },
                     ),
                     const SizedBox(height: 50,),
                     TextFormField(
                       controller: phoneController,
                       style: const TextStyle(color: Colors.white70),
                       decoration: const InputDecoration(
                           hintText: 'Your Phone Number',
                           fillColor: Colors.red,
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                               color: Colors.white12,
                               width: 2.0,
                             ),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                               color: Colors.white,
                               width: 2.0,
                             ),
                           ),
                           icon: Icon(Icons.phone_outlined, color: Colors.blue),
                           hintStyle: TextStyle(color: Colors.white24, fontSize: 14, fontWeight: FontWeight.w900)
                       ),
                       validator: (val){
                         if(val == null || val.length < 10){
                           return 'please enter a valid value';
                         }
                       },
                     ),
                     const SizedBox(height: 50,),
                     TextFormField(
                       controller: addressController,
                       style: const TextStyle(color: Colors.white70),
                       decoration: const InputDecoration(
                           hintText: 'Your Address',
                           fillColor: Colors.red,
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                               color: Colors.white12,
                               width: 2.0,
                             ),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                               color: Colors.white,
                               width: 2.0,
                             ),
                           ),
                           icon: Icon(Icons.location_on_outlined, color: Colors.blue),
                           hintStyle: TextStyle(color: Colors.white24, fontSize: 14, fontWeight: FontWeight.w900)
                       ),
                       validator: (val){
                         if(val == null || val.length <= 5){
                           return 'please enter a valid value';
                         }
                       },
                     ),
                   ],
                 ),
               ),
             )
            ]),
          )
        ],

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        color: Colors.green,
        width: double.infinity,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: OutlinedButton.icon(
            icon: Icon(Icons.arrow_left_outlined, color: Colors.white,),
            label: Text('Continue', style: Global.kPrimaryLabel.copyWith(color: Colors.black, fontSize: 18),),
            onPressed: submitForm,
          ),
        ),
      ),
    );
  }
}
