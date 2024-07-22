import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'layout/MainLayout.dart';
import 'login.dart';
import 'pantallas/Contactanos.dart';
import 'pantallas/NuestrasTiendas.dart';
import 'pantallas/SobreNosotros.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/nuestras_tiendas': (context) => const NuestrasTiendas(),
        '/sobre_nosotros': (context) => const SobreNosotros(),
        '/contactanos': (context) => const Contactanos(),
        '/login': (context) => LoginForm(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      content: Center(
        child: Text('Contenido de la página principal'),
      ),
    );
  }
}
