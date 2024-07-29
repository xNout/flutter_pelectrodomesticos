import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/CartItem.dart';
import '../AppConstants.dart';
import '../layout/MainLayout.dart';
import 'CartItemWidget.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [];
  bool isLoading = true;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc('userId') // Reemplaza 'userId' con el ID del usuario real
          .collection('items')
          .get();

      List<CartItem> fetchedCartItems = cartSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return CartItem(
          id: doc.id,
          name: data['name'],
          image: data['image'],
          price: data['price'].toDouble(),
          quantity: data['quantity'].toDouble(),
        );
      }).toList();

      double calculatedTotalAmount = fetchedCartItems.fold(
          0.0, (sum, item) => sum + item.price * item.quantity);

      setState(() {
        cartItems = fetchedCartItems;
        totalAmount = calculatedTotalAmount;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching cart items: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc('userId') // Reemplaza 'userId' con el ID del usuario real
          .collection('items')
          .doc(cartItemId)
          .delete();

      setState(() {
        cartItems.removeWhere((item) => item.id == cartItemId);
        totalAmount = cartItems.fold(
            0.0, (sum, item) => sum + item.price * item.quantity);
      });
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mi Carrito',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: CartItemWidget(
                          cartItem: cartItem,
                          onRemove: () => removeFromCart(cartItem.id),
                        ),
                      );
                    },
                  ),
          ),
          if (!isLoading)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$$totalAmount',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppConstants.sylusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Implementar funcionalidad de ordenar ahora
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppConstants.sylusColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Ordenar ahora',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
