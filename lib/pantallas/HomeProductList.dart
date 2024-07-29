import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../AppConstants.dart';
import '../layout/BtCard.dart';
import '../layout/LoadingIndicator.dart';
import '../models/Category.dart';
import '../models/Product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Category> categories = [];
  Map<String, Product> productsByCategory = {};
  Map<String, bool> favoriteStatus = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategoriesAndProducts();
  }

  Future<void> fetchCategoriesAndProducts() async {
    try {
      QuerySnapshot categorySnapshot =
          await FirebaseFirestore.instance.collection('categorias').get();
      List<Category> fetchedCategories = categorySnapshot.docs
          .map((doc) => Category.fromDocument(doc))
          .toList();

      Map<String, Product> fetchedProductsByCategory = {};
      for (Category category in fetchedCategories) {
        QuerySnapshot productSnapshot = await FirebaseFirestore.instance
            .collection('productos')
            .where('categoriaid', isEqualTo: category.id)
            .limit(1)
            .get();

        if (productSnapshot.docs.isNotEmpty) {
          fetchedProductsByCategory[category.id] =
              Product.fromDocument(productSnapshot.docs.first);
          favoriteStatus[productSnapshot.docs.first.id] = false;
        }
      }

      DocumentSnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlist')
          .doc('userId')
          .get();

      if (wishlistSnapshot.exists) {
        List<String> wishlistProductIds =
            List<String>.from(wishlistSnapshot.get('products'));
        for (String productId in wishlistProductIds) {
          if (favoriteStatus.containsKey(productId)) {
            favoriteStatus[productId] = true;
          }
        }
      }

      setState(() {
        categories = fetchedCategories;
        productsByCategory = fetchedProductsByCategory;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> toggleWishlist(String productId, bool isAdding) async {
    try {
      await FirebaseFirestore.instance
          .collection('wishlist')
          .doc('userId') // Reemplaza 'userId' con el ID del usuario real
          .set({
        'products': isAdding
            ? FieldValue.arrayUnion([productId])
            : FieldValue.arrayRemove([productId])
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating wishlist: $e');
    }
  }

  Future<void> addToCart(Product product) async {
    LoadingOverlay().show(context);

    try {
      DocumentReference cartRef = FirebaseFirestore.instance
          .collection('cart')
          .doc('userId') // Reemplaza 'userId' con el ID del usuario real
          .collection('items')
          .doc(product.id);

      DocumentSnapshot cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        cartRef.update({
          'quantity': FieldValue.increment(1),
        });
      } else {
        cartRef.set({
          'name': product.name,
          'image': product.image,
          'price': product.price,
          'quantity': 1,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se añadió el producto al carrito')),
      );
    } catch (e) {
      print('Error adding to cart: $e');
    } finally {
      LoadingOverlay().hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final product = productsByCategory[category.id];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (product != null)
                    BtCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.memory(
                              base64Decode(product.image),
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                              child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  favoriteStatus[product.id] == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoriteStatus[product.id] == true
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (favoriteStatus[product.id] == null) {
                                      favoriteStatus[product.id] = false;
                                    }
                                    bool status = !favoriteStatus[product.id]!;
                                    favoriteStatus[product.id] = status;

                                    toggleWishlist(product.id, status);
                                  });
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  addToCart(product);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: AppConstants.sylusColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Añadir',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          );
  }
}
