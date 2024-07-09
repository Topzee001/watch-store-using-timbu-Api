import 'package:flutter/material.dart';
import 'package:timbu_app/model/watch.dart';

class CartItem extends StatelessWidget {
  final Watch product;
  final VoidCallback onRemove;

  CartItem({required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(product.imageUrl),
            ),
          ),
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: onRemove,
            ),
          ),
        ),
      ),
    );
  }
}
