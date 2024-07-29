import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../AppConstants.dart';
import '../layout/LoadingIndicator.dart';
import '../layout/MainLayout.dart';

class Contactanos extends StatefulWidget {
  const Contactanos({super.key});

  @override
  _ContactanosState createState() => _ContactanosState();
}

class _ContactanosState extends State<Contactanos> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      LoadingOverlay().show(context);

      try {
        // Agregar datos a Firebase
        await FirebaseFirestore.instance.collection('contactoMessages').add({
          'nombres': _nameController.text.trim(),
          'telefono': _contactNumberController.text.trim(),
          'ciudad': _cityController.text.trim(),
          'informacion': _infoController.text.trim(),
          'fecha': DateTime.now().toIso8601String(),
        });

        // Limpiar el formulario
        _formKey.currentState!.reset();
        _nameController.clear();
        _contactNumberController.clear();
        _cityController.clear();
        _infoController.clear();

        // Mostrar mensaje de confirmación
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Gracias! Hemos recibido tu mensaje')),
        );
      } catch (e) {
        // Manejar errores si es necesario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hubo un error, inténtalo de nuevo.')),
        );
      } finally {
        LoadingOverlay().hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '¡Hola!',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      TextSpan(
                        text:
                            ' Te damos la bienvenida a nuestro formulario de contacto.\n\n',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      TextSpan(
                        text:
                            'Estamos aquí para ayudarte con cualquier consulta que tengas sobre nuestros productos y/o servicios. Por favor, rellena el formulario y nos pondremos en contacto contigo lo antes posible.',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: inputDecoration("Nombres y apellidos"),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingrese su nombre completo';
                          } else if (value.length < 5) {
                            return 'Ingrese al menos 5 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _contactNumberController,
                        decoration: inputDecoration("Número de contacto"),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          String? val = value?.trim();
                          if (val == null || val.isEmpty) {
                            return 'Por favor ingrese su número de contacto';
                          } else if (val.length < 10) {
                            return 'Su número debe tener al menos 10 dígitos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _cityController,
                        decoration: inputDecoration("Ciudad"),
                        validator: (value) {
                          String? val = value?.trim();
                          if (val == null || val.isEmpty) {
                            return 'Por favor ingrese su ciudad';
                          } else if (val.length < 3) {
                            return 'Ingrese al menos 3 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _infoController,
                        decoration: inputDecoration("Información"),
                        maxLines: 5,
                        validator: (value) {
                          String? val = value?.trim();
                          if (val == null || val.isEmpty) {
                            return 'Por favor ingrese la información solicitada';
                          } else if (val.length < 4) {
                            return 'Ingrese al menos 4 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppConstants.sylusColor,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Enviar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black87,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppConstants.sylusColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
