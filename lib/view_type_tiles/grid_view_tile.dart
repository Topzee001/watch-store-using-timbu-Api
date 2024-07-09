import 'package:flutter/material.dart';

import '../model/watch.dart';

class GridViewTile extends StatelessWidget {
  final Watch product;
  final VoidCallback onAddToCart;

  GridViewTile({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  //width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Image.network(product.imageUrl,
                      errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.watch);
                  }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${product.price.toStringAsFixed(2)}'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: onAddToCart,
                  icon: Icon(Icons.add_shopping_cart),
                  iconSize: 20,
                  // padding: EdgeInsets.all(4),
                  constraints: BoxConstraints(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
