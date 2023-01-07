import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_provider/providers/products_provider.dart';
import 'package:shop_app_provider/screens/cart_screen.dart';

//import 'package:shop_app_provider/providers/products_provider.dart';
import 'package:shop_app_provider/widgets/badge.dart';
import 'package:shop_app_provider/providers/cart.dart';
import 'package:shop_app_provider/widgets/products_grid.dart';
import 'package:shop_app_provider/widgets/app_drawer.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<ProductsProvider>(context).fetchAndSetProducts(); //WONT WORK
    /* // This is one approach to solve this
    Future.delayed(Duration.zero).then((_) {
      Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    });

     */
    setState(() {});
    super.initState();
  }

  /*This method will run after the widget has been fully initialized but
  before build ran for the first time. Unlike initstate it will run more
  often multiple times and not just when this gets created.
   */
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showOnlyFavorites),
    );
  }
}
