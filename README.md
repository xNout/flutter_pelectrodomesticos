# Flutter Pelectrodomésticos

Proyecto final basado en una tienda de electrodomésticos, desarrollado con Flutter.

## Descripción

Esta aplicación es una tienda de electrodomésticos que permite a los usuarios navegar por diferentes categorías de productos, agregar productos a su carrito de compras, y gestionar su lista de deseos. La aplicación está diseñada para ser intuitiva y fácil de usar, proporcionando una experiencia de compra agradable.

## Características

- **Inicio de Sesión y Registro**: Los usuarios pueden registrarse y acceder a la aplicación mediante un sistema de autenticación.
- **Navegación por Categorías**: Los usuarios pueden explorar productos categorizados.
- **Carrito de Compras**: Funcionalidad para agregar productos al carrito y proceder a la compra.
- **Lista de Deseos**: Los usuarios pueden guardar productos en su lista de deseos para futuras compras.
- **Página de Inicio**: Muestra el contenido principal de la tienda.
- **Menú Desplegable**: Incluye opciones para 'Nuestras Tiendas', 'Sobre Nosotros' y 'Contáctanos'.
- **Barra de Navegación Inferior**: Para una navegación rápida entre Inicio, Categorías, Lista de Deseos y Carrito.

## Estructura del Proyecto

El proyecto sigue una estructura típica de Flutter, con las siguientes carpetas y archivos clave:

- `lib/`: Contiene el código fuente de la aplicación.
  - `main.dart`: Punto de entrada de la aplicación.
  - `screens/`: Contiene las diferentes pantallas de la aplicación.
  - `widgets/`: Componentes reutilizables de la UI.
- `assets/`: Contiene recursos estáticos como imágenes y fuentes.
- `pubspec.yaml`: Archivo de configuración y gestión de dependencias.

## Dependencias Principales

- `flutter`
- `firebase_auth`
- `cloud_firestore`
- `provider`

Para una lista completa de dependencias, revisa el archivo `pubspec.yaml`.

## Instalación y Configuración

1. Clona este repositorio:
   ```sh
   git clone https://github.com/xNout/flutter_pelectrodomesticos.git

2. Navega al directorio del proyecto:
   ```sh
   cd flutter_pelectrodomesticos


3. Instala las dependencias:
   ```sh
   flutter pub get

4. Configura Firebase para la autenticación y Firestore.
5. Corre la aplicación:
   ```sh
   flutter run
