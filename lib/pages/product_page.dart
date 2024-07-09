import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_app/view_type_tiles/list_view_tile.dart';
import '../view_type_tiles/grid_view_tile.dart';
import '../providers/cart_provider.dart';

enum ViewType { list, grid }

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ViewType _viewType = ViewType.list;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shop Your Luxury Watches'),
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _viewType = _viewType == ViewType.list
                    ? ViewType.grid
                    : ViewType.list;
              });
            },
            icon: Icon(
              _viewType == ViewType.list ? Icons.grid_view : Icons.view_list,
            ),
          ),
        ],
      ),
      body: cartProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartProvider.errorMessage != null
              ? Center(child: Text(cartProvider.errorMessage!))
              : _viewType == ViewType.list
                  ? ListView.builder(
                      padding: const EdgeInsets.all(15),
                      itemCount: cartProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = cartProvider.products[index];
                        return ListViewTile(
                          product: product,
                          onAddToCart: () {
                            cartProvider.addToCart(product);
                          },
                        );
                      },
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                      ),
                      padding: const EdgeInsets.all(15),
                      itemCount: cartProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = cartProvider.products[index];
                        return GridViewTile(
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
    );
  }
}
