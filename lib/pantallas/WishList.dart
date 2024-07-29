import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Product.dart';
import '../AppConstants.dart';
import '../layout/BtCard.dart';
import '../layout/MainLayout.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<Product> wishlistProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWishlistProducts();
  }

  Future<void> fetchWishlistProducts() async {
    try {
      DocumentSnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlist')
          .doc('userId') // Reemplaza 'userId' con el ID del usuario real
          .get();

      if (wishlistSnapshot.exists) {
        List<String> productIds =
            List<String>.from(wishlistSnapshot.get('products'));

        List<Product> fetchedProducts = [];
        for (String productId in productIds) {
          DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
              .collection('productos')
              .doc(productId)
              .get();

          if (productSnapshot.exists) {
            fetchedProducts.add(Product.fromDocument(productSnapshot));
          }
        }

        setState(() {
          wishlistProducts = fetchedProducts;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching wishlist products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('wishlist')
          .doc('userId') // Reemplaza 'userId' con el ID del usuario real
          .update({
        'products': FieldValue.arrayRemove([productId])
      });

      setState(() {
        wishlistProducts.removeWhere((product) => product.id == productId);
      });
    } catch (e) {
      print('Error removing from wishlist: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: wishlistProducts.length,
              itemBuilder: (context, index) {
                final product = wishlistProducts[index];

                return BtCard(
                  child: Row(
                    children: [
                      Image.memory(
                        base64Decode(product.image),
                        height: 60,
                        width: 30,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => removeFromWishlist(product.id),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
