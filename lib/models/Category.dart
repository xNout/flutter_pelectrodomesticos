import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final String logo;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
  });

  factory Category.fromDocument(DocumentSnapshot doc) {
    return Category(
      id: doc.id,
      name: doc['nombre'],
      description: doc['descripcion'],
      logo: doc['logo'],
    );
  }
}
