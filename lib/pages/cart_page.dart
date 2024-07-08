import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart_items.dart';
import '../providers/product_provider.dart';
import 'order_success_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: productProvider.cart.isEmpty
          ? Center(child: Text('No items in cart'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: productProvider.cart.length,
                    itemBuilder: (context, index) {
                      final product = productProvider.cart[index];
                      return CartItem(
                        product: product,
                        onRemove: () => productProvider.removeFromCart(product),
                      );
                    },
                  ),
                ),
                Text(
                    'Total: \$${productProvider.totalPrice.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                //if (widget.cartModel.cartItems.isNotEmpty)
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
                    // widget.cartModel.clearCart();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const MyOrderSuccess()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
    );
  }
}
