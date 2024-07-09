import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart_items.dart';
import '../providers/cart_provider.dart';
import 'homepage.dart';
import 'order_success_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          title: const Text('Cart'),
          centerTitle: true,
          backgroundColor: Colors.grey.shade100,
        ),
        body: cartProvider.cartItems.isEmpty
            ? const Center(child: Text('No items added to cart'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartProvider.cartItems[index];
                        return CartItem(
                            product: product,
                            onRemove: () {
                              cartProvider.removeFromCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${product.name} removed from cart'),
                                  duration: const Duration(milliseconds: 1000),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  Text(
                    'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // if (widget.cartModel.cartItems.isNotEmpty)
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.purple,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Checkout',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      //widget.cartProvider.clearCart();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const MyOrderSuccess()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
