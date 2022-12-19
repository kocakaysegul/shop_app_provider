import 'package:flutter/material.dart';
import 'package:shop_app_provider/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.indigo.shade100.withOpacity(0.4),
          leading: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {}),
          title: Text(title, style: TextStyle(color: Theme.of(context).primaryColorDark),),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart_rounded,
                  color: Theme.of(context).primaryColorDark),
              onPressed: () {}),
        ),
      ),
    );
  }
}
