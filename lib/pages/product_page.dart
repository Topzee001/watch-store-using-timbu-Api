import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_tile.dart';
import '../providers/cart_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shop your luxury watches'),
        backgroundColor: Colors.grey.shade100,
      ),
      body: cartProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartProvider.errorMessage != null
              ? Center(child: Text(cartProvider.errorMessage!))
              : SizedBox(
                  //height: 550,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    padding: const EdgeInsets.all(15),
                    itemCount: cartProvider.products.length,
                    itemBuilder: (context, index) {
                      final product = cartProvider.products[index];
                      return ProductTile(
                        product: product,
                        onAddToCart: () {
                          cartProvider.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} added to cart'),
                              duration: const Duration(milliseconds: 1000),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
