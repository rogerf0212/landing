import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  int _selectedIndex = 0;

  Future<void> _realizarSorteo() async {
    final registrosSnapshot =
        await FirebaseFirestore.instance.collection('registros').get();
    final ganadoresSnapshot =
        await FirebaseFirestore.instance.collection('ganadores').get();

    final registros = registrosSnapshot.docs;
    final ganadores = ganadoresSnapshot.docs;

    final random = Random();
    DocumentSnapshot? winner;

    do {
      winner = registros[random.nextInt(registros.length)];
    } while (ganadores.any(
        (ganador) => ganador['codigoProducto'] == winner!['codigoProducto']));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Ganador!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${winner!['nombre']}'),
              Text('No. de Identidad: ${winner!['NodeIdentidad']}'),
              Text('Teléfono: ${winner!['telefono']}'),
              Text('Email: ${winner!['email']}'),
              Text('Producto: ${winner!['codigoProducto']}'),
              Text('Realizó Compra: ${winner!['realizoCompra']}'),
              Text('Numero de participacion: ${winner!['Noparticipacion']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Guardar el ganador en la colección "ganadores"
                final ganadorData = {
                  'nombre': winner!['nombre'],
                  'NodeIdentidad': winner!['NodeIdentidad'],
                  'telefono': winner!['telefono'],
                  'email': winner!['email'],
                  'codigoProducto': winner!['codigoProducto'],
                  'realizoCompra': winner!['realizoCompra'],
                  'Noparticipacion': winner!['Noparticipacion'],
                };

                await FirebaseFirestore.instance
                    .collection('ganadores')
                    .add(ganadorData);
                Navigator.of(context).pop();
                // Guardar el ganador en la colección "ganadores"
                // (código para guardar el ganador aquí)
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            backgroundColor: Colors.black,
            unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
            unselectedLabelTextStyle: TextStyle(color: Colors.white),
            selectedIconTheme: IconThemeData(color: Colors.deepPurple.shade900),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_add),
                label: Text("Registros",
                    textAlign:
                        TextAlign.left), // Alinea el texto a la izquierda
              ),
              NavigationRailDestination(
                icon: Icon(Icons.sort),
                label: Text("Sorteo"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star),
                label: Text("Ganadores"),
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Usuarios Registrados",
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('registros')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text(
                                            'Error al cargar los datos');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text('Cargando...');
                                      }
                                      final numberOfEntries =
                                          snapshot.data?.docs.length ?? 0;
                                      return Text(
                                        '$numberOfEntries',
                                        style: TextStyle(
                                          fontSize: 36.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Ganadores",
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('ganadores')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text(
                                            'Error al cargar los datos');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text('Cargando...');
                                      }
                                      final numberOfWinners =
                                          snapshot.data?.docs.length ?? 0;
                                      return Text(
                                        '$numberOfWinners',
                                        style: TextStyle(
                                          fontSize: 36.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para exportar registros
                          },
                          child: Text('Exportar Registros'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para exportar ganadores
                          },
                          child: Text('Exportar Ganadores'),
                        ),
                      ],
                    ),
                    if (_selectedIndex == 1)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('registros')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error al cargar los datos');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('Cargando...');
                            }

                            final entries = snapshot.data?.docs ?? [];

                            return DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors
                                      .grey), // Color de fondo de la fila de títulos
                              dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors
                                      .white), // Color de fondo de las filas de datos
                              columns: [
                                DataColumn(label: Text("Nombre")),
                                DataColumn(label: Text("No. de Identidad")),
                                DataColumn(label: Text("Teléfono")),
                                DataColumn(label: Text("Email")),
                                DataColumn(label: Text("Producto")),
                                DataColumn(label: Text("Establecimiento")),
                                DataColumn(label: Text("No. Participacion")),

                              ],
                              rows: entries.map((entry) {
                                final nombre = entry['nombre'] ?? '';
                                final cedula = entry['NodeIdentidad'] ?? '';
                                final telefono = entry['telefono'] ?? '';
                                final email = entry['email'] ?? '';
                                final producto = entry['codigoProducto'] ?? '';
                                final establecimiento = entry['realizoCompra'] ?? '';
                                final Noparticipacion = entry['Noparticipacion'] ?? '';

                                return DataRow(cells: [
                                  DataCell(Text(nombre)),
                                  DataCell(Text(cedula)),
                                  DataCell(Text(telefono)),
                                  DataCell(Text(email)),
                                  DataCell(Text(producto)),
                                  DataCell(Text(establecimiento)),
                                  DataCell(Text(Noparticipacion)),
                                ]);
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    if (_selectedIndex == 3)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('ganadores')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error al cargar los datos');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('Cargando...');
                            }

                            final winners = snapshot.data?.docs ?? [];

                            return DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey),
                              dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              columns: [
                                DataColumn(label: Text("Nombre")),
                                DataColumn(label: Text("No. de Identidad")),
                                DataColumn(label: Text("Teléfono")),
                                DataColumn(label: Text("Email")),
                                DataColumn(label: Text("Producto")),
                                DataColumn(label: Text("Establecimiento")),
                                DataColumn(label: Text("No de Participacion")),
                              ],
                              rows: winners.map((winner) {
                                final nombre = winner['nombre'] ?? '';
                                final cedula = winner['NodeIdentidad'] ?? '';
                                final telefono = winner['telefono'] ?? '';
                                final email = winner['email'] ?? '';
                                final producto = winner['codigoProducto'] ?? '';
                                final establecimiento = winner['realizoCompra'] ?? '';
                                final Noparticipacion = winner['Noparticipacion'] ?? '';


                                return DataRow(cells: [
                                  DataCell(Text(nombre)),
                                  DataCell(Text(cedula)),
                                  DataCell(Text(telefono)),
                                  DataCell(Text(email)),
                                  DataCell(Text(producto)),
                                  DataCell(Text(establecimiento)),
                                  DataCell(Text(Noparticipacion)),
                                ]);
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    if (_selectedIndex == 2) // Pestaña "Sorteo"
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Sorteo',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: _realizarSorteo,
                              child: Text('Realizar Sorteo'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
