import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientMaintenanceScreen extends StatefulWidget {
  @override
  _ClientMaintenanceScreenState createState() =>
      _ClientMaintenanceScreenState();
}

class _ClientMaintenanceScreenState extends State<ClientMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _razonSocialController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('clientes');

  List<DocumentSnapshot> _clients = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchClients);
    _fetchClients();
  }

  void _fetchClients() async {
    final snapshot = await _clientsCollection.get();
    setState(() {
      _clients = snapshot.docs;
    });
  }

  void _searchClients() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      _clients = _clients.where((client) {
        return client['razon_social'].toLowerCase().contains(searchText) ||
            client['ruc'].toLowerCase().contains(searchText) ||
            client['direccion'].toLowerCase().contains(searchText) ||
            client['correo'].toLowerCase().contains(searchText);
      }).toList();
    });
  }

  Future<bool> _isRucUnique(String ruc) async {
    final snapshot =
        await _clientsCollection.where('ruc', isEqualTo: ruc).get();
    return snapshot.docs.isEmpty;
  }

  void _createClient() async {
    if (_formKey.currentState!.validate()) {
      final isRucUnique = await _isRucUnique(_rucController.text);
      if (!isRucUnique) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('El RUC ya existe.'),
        ));
        return;
      }
      await _clientsCollection.add({
        'razon_social': _razonSocialController.text,
        'ruc': _rucController.text,
        'direccion': _direccionController.text,
        'correo': _correoController.text,
      });
      _clearControllers();
      _fetchClients();
      Navigator.of(context).pop();
    }
  }

  void _updateClient(String id) async {
    if (_formKey.currentState!.validate()) {
      final isRucUnique = await _isRucUnique(_rucController.text);
      if (!isRucUnique) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('El RUC ya existe.'),
        ));
        return;
      }
      await _clientsCollection.doc(id).update({
        'razon_social': _razonSocialController.text,
        'ruc': _rucController.text,
        'direccion': _direccionController.text,
        'correo': _correoController.text,
      });
      _clearControllers();
      _fetchClients();
      Navigator.of(context).pop();
    }
  }

  void _clearControllers() {
    _razonSocialController.clear();
    _rucController.clear();
    _direccionController.clear();
    _correoController.clear();
  }

  void _showEditDialog(DocumentSnapshot client) {
    _razonSocialController.text = client['razon_social'];
    _rucController.text = client['ruc'];
    _direccionController.text = client['direccion'];
    _correoController.text = client['correo'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Actualizar Cliente'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _razonSocialController,
                    decoration: InputDecoration(labelText: 'Razón Social'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la razón social';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _rucController,
                    decoration: InputDecoration(labelText: 'RUC'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el RUC';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _direccionController,
                    decoration: InputDecoration(labelText: 'Dirección'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la dirección';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _correoController,
                    decoration: InputDecoration(labelText: 'Correo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el correo';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Por favor ingrese un correo válido';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _updateClient(client.id);
              },
              child: Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  void _showCreateDialog() {
    _clearControllers();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Crear Cliente'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _razonSocialController,
                    decoration: InputDecoration(labelText: 'Razón Social'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la razón social';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _rucController,
                    decoration: InputDecoration(labelText: 'RUC'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el RUC';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _direccionController,
                    decoration: InputDecoration(labelText: 'Dirección'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la dirección';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _correoController,
                    decoration: InputDecoration(labelText: 'Correo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el correo';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Por favor ingrese un correo válido';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _createClient();
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mantenimiento de Clientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(labelText: 'Buscar Clientes'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showCreateDialog,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _clients.length,
                itemBuilder: (context, index) {
                  final client = _clients[index];
                  return ListTile(
                    title: Text(client['razon_social']),
                    subtitle: Text(client['correo']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showEditDialog(client),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _clientsCollection.doc(client.id).delete();
                            _fetchClients();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
