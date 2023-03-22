import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/cartProvider.dart';
import 'package:restaurant_app/providers/categoryProvider.dart';
import 'package:restaurant_app/providers/menuProvider.dart';
import 'package:restaurant_app/providers/productProvider.dart';
import 'package:restaurant_app/screens/cart_screen.dart';
import 'package:restaurant_app/screens/checkout_screen.dart';
import 'package:restaurant_app/screens/confirm_screen.dart';
import 'package:restaurant_app/screens/home_search.dart';
import 'package:restaurant_app/screens/menuScreen.dart';
import 'package:restaurant_app/screens/productScreen.dart';
import 'package:restaurant_app/screens/success.dart';
import 'package:restaurant_app/screens/testing.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => MenuProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white10,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white70
            )
          ),
          primarySwatch: Colors.blue,
        ),
          routes: {
            // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            MenuScreen.routeName : (_) => const MenuScreen(),
            ProductScreen.routeName : (_) =>  const ProductScreen(),
            ProviderScreen.routeName : (_) => const ProviderScreen(),
            CartScreen.routeName : (_) => const CartScreen(),
            CheckOutScreen.routeName : (_) => const CheckOutScreen(),
            ConfirmScreen.routeName : (_) => const ConfirmScreen(),
            SearchProduct.routeName : (_) => SearchProduct(query: ''),
            SuccessScreen.routeName : (_) => const SuccessScreen(),
          },
        home: const SafeArea(child: HomeScreen())
      ),
    );
  }
}
