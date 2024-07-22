import 'package:flutter/material.dart';

class NuestrasTiendas extends StatelessWidget {
  const NuestrasTiendas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuestras Tiendas'),
      ),
      body: const Center(
        child: Text('Contenido de Nuestras Tiendas'),
      ),
    );
  }
}
