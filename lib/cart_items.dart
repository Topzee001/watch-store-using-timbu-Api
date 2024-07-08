import 'package:flutter/material.dart';
import 'package:timbu_app/model/product.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  CartItem({required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.imageUrl),
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(Icons.remove_shopping_cart),
        onPressed: onRemove,
      ),
    );
  }
}
