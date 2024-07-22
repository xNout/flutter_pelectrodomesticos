import 'package:flutter/material.dart';

import '../AppConstants.dart';

class Menulayout extends StatelessWidget {
  const Menulayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: DrawerHeader(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppConstants.LogoPath,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Nuestras tiendas'),
            onTap: () {
              Navigator.pushNamed(context, '/nuestras_tiendas');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre nosotros'),
            onTap: () {
              Navigator.pushNamed(context, '/sobre_nosotros');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contáctanos'),
            onTap: () {
              Navigator.pushNamed(context, '/contactanos');
            },
          ),
        ],
      ),
    );
  }
}
