import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../layout/MainLayout.dart';
import '../layout/BtCard.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
        child: Column(
          children: [
            BtCard(
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Categorias',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            /* const BtCard(
              child: SizedBox(height: 2),
            ), */
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('categorias')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error al cargar categorías');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center();
                  }
                  final categories = snapshot.data?.docs ?? [];
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(
                            12, 5, 10, 0), // Margen alrededor de cada tarjeta
                        child: CategoryGridItem(
                          id: category.id,
                          name: category['nombre'],
                          logo: category['logo'],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryGridItem extends StatelessWidget {
  final String name;
  final String? logo;
  final String id;

  const CategoryGridItem({
    Key? key,
    required this.id,
    required this.name,
    this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logoBytes = logo != null ? base64Decode(logo!) : null;
    return InkWell(
      onTap: () => {print("Hello: ${id}")},
      child: BtCard(
        shadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: logoBytes != null
                  ? Image.memory(
                      logoBytes,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image,
                            size: 48, color: Colors.grey);
                      },
                    )
                  : Image.asset(
                      'images/filenotfound.png', // Ruta de la imagen por defecto
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final String logo;

  const CategoryCard({
    super.key,
    required this.name,
    required this.description,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                logo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, size: 48, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
