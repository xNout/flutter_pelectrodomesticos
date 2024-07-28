import 'package:flutter/material.dart';

import '../layout/MainLayout.dart';

class Contactanos extends StatelessWidget {
  const Contactanos({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      content: Center(
        child: Text('Contenido de la página contacto'),
      ),
    );
  }
}
