import 'package:flutter/material.dart';
import 'package:shop_app_provider/screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyShop",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.pink
      ),
      home: ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
      },
    );
  }
}
