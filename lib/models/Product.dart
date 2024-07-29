import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String model;
  final String brand;
  final String image;
  final double price;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.model,
    required this.brand,
    required this.image,
    required this.price,
    required this.categoryId,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      name: doc['nombre'],
      model: doc['modelo'],
      brand: doc['marca'],
      image: doc['imagen'],
      price: doc['precio'].toDouble(),
      categoryId: doc['categoriaid'],
    );
  }
}
