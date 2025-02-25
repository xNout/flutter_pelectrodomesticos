import 'package:flutter/material.dart';

import '../AppConstants.dart';

class FooterLayout extends StatefulWidget {
  const FooterLayout(
      {super.key, required this.onItemTapped, required this.selectedIndex});

  final Function(int) onItemTapped;
  final int selectedIndex;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<FooterLayout> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/categorias');
        break;
      case 2:
        Navigator.pushNamed(context, '/wishlist');
        break;
      case 3:
        Navigator.pushNamed(context, '/cart');
        break;
    }
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Lista de deseos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Carrito',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: AppConstants.sylusColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 8),
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}
