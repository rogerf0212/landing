import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'colreg.dart'; // Asegúrate de tener la clase Colmado definida

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
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
                // Accede directamente a los campos del mapa
                String nombre = colmadoData['nombre'];
                String cedula = colmadoData['cedula'];

                return Card(
                  child: ListTile(
                    title: Text(nombre),
                    subtitle: Text(cedula),
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
