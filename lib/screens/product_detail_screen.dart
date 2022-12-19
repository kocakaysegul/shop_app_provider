import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_provider/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  //final String title;
  //final double price;
  //ProductDetailScreen(this.title, this.price);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProducts =
        Provider.of<ProductsProvider>(context, listen: false).findById(prodId);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProducts.title)),
    );
  }
}
