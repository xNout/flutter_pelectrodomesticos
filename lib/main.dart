import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prfinal/pantallas/WishList.dart';
import 'firebase_options.dart';
import 'layout/MainLayout.dart';
import 'login.dart';
import 'pantallas/Categories.dart';
import 'pantallas/Contactanos.dart';
import 'pantallas/HomePage.dart';
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
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/wishlist': (context) => Wishlist(),
        '/nuestras_tiendas': (context) => const NuestrasTiendas(),
        '/sobre_nosotros': (context) => const SobreNosotros(),
        '/contactanos': (context) => const Contactanos(),
        '/categorias': (context) => const Categories(),
        '/login': (context) => LoginForm(),
      },
    );
  }
}
