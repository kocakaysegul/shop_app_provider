import 'package:flutter/material.dart';
import 'package:shop_app_provider/screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_provider/providers/products_provider.dart';
import 'package:shop_app_provider/providers/cart.dart';
import 'package:shop_app_provider/screens/cart_screen.dart';
import 'package:shop_app_provider/providers/order.dart';
import 'package:shop_app_provider/screens/orders_screen.dart';
import 'package:shop_app_provider/screens/user_product_screen.dart';
import 'package:shop_app_provider/screens/edit_product_screen.dart';
import 'package:shop_app_provider/screens/auth_screen.dart';
import 'package:shop_app_provider/providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),//bcz of latest version build -> create
        ChangeNotifierProvider(create: (ctx) =>Cart()),
        ChangeNotifierProvider(create: (ctx) => Order()),
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) =>MaterialApp(
        title: "MyShop",
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.pink
        ),
        home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
        routes: {
          ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
          CartScreen.routeName : (ctx) => CartScreen(),
          OrdersScreen.routeName : (ctx) => OrdersScreen(),
          UserProductsScreen.routeName : (ctx) => UserProductsScreen(),
          EditProductScreen.routeName : (ctx) => EditProductScreen(),
        },
      )) ,
    );
  }
}
