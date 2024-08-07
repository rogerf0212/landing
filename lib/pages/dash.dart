import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String activeTab = 'registros'; // Inicialmente muestra los registros

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 120, // Ancho para los botones
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8), // Agrega margen
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOption('Registros'),
                _buildOption('Sorteo'),
                _buildOption('Ganadores'),
                _buildOption('Premios'),
              ],
            ),
          ),
          Expanded(
            child: _buildTabContent(activeTab), // Contenido de la pestaña activa
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeTab = text.toLowerCase(); // Cambia a la pestaña correspondiente
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String tab) {
    switch (tab) {
      case 'registros':
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('registros').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No hay datos disponibles'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var colmadoData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  String nombre = colmadoData['nombre'];
                  String cedula = colmadoData['cedula'];
                  String telefono = colmadoData['telefono'];
                  String email = colmadoData['email'];
                  String codigoProducto = colmadoData['codigoProducto'];
                  String realizoCompra = colmadoData['realizoCompra']; // Nuevo campo

                  return Card(
                    child: ListTile(
                      title: Text('Nombre: $nombre'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cédula: $cedula'),
                          Text('Número: $telefono'),
                          Text('Email: $email'),
                          Text('Código del Producto: $codigoProducto'),
                          Text('Donde realizó la compra: $realizoCompra'), // Agrega el nuevo campo
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      case 'sorteo':
        return Center(
          child: ElevatedButton(
  onPressed: () async {
    // Consulta Firestore para obtener todos los documentos de la colección "participantes"
    final querySnapshot = await FirebaseFirestore.instance.collection('registros').get();

    
    if (querySnapshot.docs.isNotEmpty) {
      // Genera un índice aleatorio
      final randomIndex = Random().nextInt(querySnapshot.docs.length);
      final randomEntry = querySnapshot.docs[randomIndex];

      final winnerCodigoProducto = randomEntry['codigoProducto'];

      final ganadoresSnapshot = await FirebaseFirestore.instance.collection('ganadores')
          .where('codigoProducto', isEqualTo: winnerCodigoProducto)
          .get();

      if (ganadoresSnapshot.docs.isEmpty) {
      // Accede a los datos relevantes
      final winnerData = {
        'nombre': randomEntry['nombre'],
        'cedula': randomEntry['cedula'],
        'telefono': randomEntry['telefono'],
        'email': randomEntry['email'],
        'codigoProducto': randomEntry['codigoProducto'],
        'realizoCompra': randomEntry['realizoCompra'],
      };

      await FirebaseFirestore.instance.collection('ganadores').add(winnerData);

      // Muestra el cuadro de diálogo con los datos del ganador
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ganador del Sorteo'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre: ${winnerData['nombre']}'),
                Text('Cédula: ${winnerData['cedula']}'),
                Text('Teléfono: ${winnerData['telefono']}'),
                Text('Email: ${winnerData['email']}'),
                Text('Código del Producto: ${winnerData['codigoProducto']}'),
                Text('Realizó una compra: ${winnerData['realizoCompra']}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cierra el cuadro de diálogo
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Participante ya registrado'),
                content: Text('Este participante ya ha sido seleccionado como ganador. Realiza el sorteo nuevamente.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Cierra el cuadro de diálogo
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        print('El código de producto ya ha sido seleccionado anteriormente.');
      }
    } else {
      // Maneja el caso cuando no hay participantes
      print('No hay participantes para el sorteo.');
    }
  },
  child: Text('Sorteo'),
),

        );
        case 'ganadores':
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('ganadores').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No hay datos disponibles'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var colmadoData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  String nombre = colmadoData['nombre'];
                  String cedula = colmadoData['cedula'];
                  String telefono = colmadoData['telefono'];
                  String email = colmadoData['email'];
                  String codigoProducto = colmadoData['codigoProducto'];
                  String realizoCompra = colmadoData['realizoCompra']; // Nuevo campo

                  return Card(
                    child: ListTile(
                      title: Text('Nombre: $nombre'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cédula: $cedula'),
                          Text('Número: $telefono'),
                          Text('Email: $email'),
                          Text('Código del Producto: $codigoProducto'),
                          Text('Donde realizó la compra: $realizoCompra'), // Agrega el nuevo campo
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      default:
        return Center(child: Text('Pestaña no implementada'));
    }
  }
}
