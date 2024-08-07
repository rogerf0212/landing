import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:landing/pages/colmado.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Colmados'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                    title: Text(nombre),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cédula: $cedula'),
                        Text('Teléfono: $telefono'),
                        Text('Email: $email'),
                        Text('Código del Producto: $codigoProducto'),
                        Text('Compra en colmado: $realizoCompra'), // Agrega el nuevo campo
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

