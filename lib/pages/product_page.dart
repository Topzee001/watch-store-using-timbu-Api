import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_tile.dart';
import '../providers/product_provider.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      appBar: AppBar(title: Text('Products')),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : productProvider.errorMessage != null
              ? Center(child: Text(productProvider.errorMessage!))
              : SizedBox(
                  //height: 550,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    padding: const EdgeInsets.all(15),
                    itemCount: productProvider.products.length,
                    itemBuilder: (context, index) {
                      final product = productProvider.products[index];
                      return ProductTile(
                        product: product,
                        onAddToCart: () => productProvider.addToCart(product),
                      );
                    },
                  ),
                ),
    );
  }
}
