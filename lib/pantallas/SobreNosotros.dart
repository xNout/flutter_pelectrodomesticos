import 'package:flutter/material.dart';

class SobreNosotros extends StatelessWidget {
  const SobreNosotros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre Nosotros'),
      ),
      body: Center(
        child: Text('Contenido de Sobre Nosotros'),
      ),
    );
  }
}
