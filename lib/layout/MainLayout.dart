import 'package:flutter/material.dart';

import '../AppConstants.dart';
import 'FooterNav.dart';
import 'MenuLayout.dart';

class MainLayout extends StatefulWidget {
  final Widget content;

  const MainLayout({super.key, required this.content});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

// lo que cambio fue que en body colocamos: widget.content
// para dibujar lo que sea que se requiera colocar aquí
class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              color: Colors.grey,
            );
          },
        ),
        title: Image.asset(
          AppConstants.sylusLogoPath,
          height: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            color: Colors.grey,
          ),
        ],
      ),
      drawer: const Menulayout(),
      body: widget.content,
      bottomNavigationBar: FooterLayout(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
