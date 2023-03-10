import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_provider/screens/product_detail_screen.dart';
import 'package:shop_app_provider/providers/product.dart';
import 'package:shop_app_provider/providers/cart.dart';

class ProductItem extends StatelessWidget {
  //final String id;
  //final String title;
  //final String imageUrl;

  //ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: productData.id);
          },
          child: Image.network(
            productData.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.indigo.shade100.withOpacity(0.4),
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
                icon: Icon(
                  productData.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Colors.purple[700],
                ),
                onPressed: () {
                  productData.toggleFavoriteStatus();
                }),
          ),
          title: Text(
            productData.title,
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart_rounded,
                  color: Theme.of(context).primaryColorDark),
              onPressed: () {
                cartData.addItem(
                    productData.id, productData.price, productData.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added item to the card'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: (){
                      cartData.removeSingleItem(productData.id);
                    },
                  ),
                ));
              }),
        ),
      ),
    );
  }
}
