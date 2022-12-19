import 'package:flutter/material.dart';
import 'package:shop_app_provider/providers/product.dart';
import 'package:shop_app_provider/widgets/product_item.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_provider/providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = productData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        //shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 9 / 12,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i], //different syntax if you're not using context
          /*
          When you're working with objects that are already exist use .value
          Otherwise if you're creating the objects for
           the first time use create: nor .value.
           */
          //create: (c) => products[i],
          child: ProductItem(
              /*products[i].id,
              products[i].title, products[i].imageUrl
               */
          ),
        ));
  }
}
