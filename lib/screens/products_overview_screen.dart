import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_provider/screens/cart_screen.dart';
//import 'package:shop_app_provider/providers/products_provider.dart';
import 'package:shop_app_provider/widgets/badge.dart';
import 'package:shop_app_provider/providers/cart.dart';
import 'package:shop_app_provider/widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    //final productContainer = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Myshop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    //productContainer.showFavoritesOnly();
                    showOnlyFavorites = true;
                  } else {
                    //productContainer.showAll();
                    showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert_sharp),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: FilterOptions.All,
                    )
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch!, //error solved
              value: cart.itemCount.toString(),
              color: Theme.of(context).primaryColorLight,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(showOnlyFavorites),
    );
  }
}
