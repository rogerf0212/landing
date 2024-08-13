import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:landing/main.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:landing/pages/colmado.dart';
import 'package:landing/pages/basepage.dart';
import 'package:landing/pages/diasort.dart';
import 'package:landing/pages/mecpage.dart';

class RegistroColmado extends StatefulWidget {
  @override
  _RegistroColmadoState createState() => _RegistroColmadoState();
}

class _RegistroColmadoState extends State<RegistroColmado> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cedulaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _codigoProductoController = TextEditingController();
  final String _realizoCompra = 'Realizó la compra en un colmado';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Consulta Firestore para verificar si el código de producto ya existe
      final existingProduct = await FirebaseFirestore.instance
          .collection('registros')
          .where('codigoProducto', isEqualTo: _codigoProductoController.text)
          .get();

      if (existingProduct.docs.isNotEmpty) {
        // El código de producto ya existe, muestra un mensaje de error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error', style: TextStyle(color: Colors.white)),
              content: Text('Este código de producto ya fue registrado.',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.lightBlue, // Fondo azul cielo
              actions: <Widget>[
                TextButton(
                  child: Text('Cerrar', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Guardar los datos en Firestore
        try {
          await FirebaseFirestore.instance.collection('registros').add({
            'nombre': _nombreController.text,
            'cedula': _cedulaController.text,
            'telefono': _telefonoController.text,
            'email': _emailController.text,
            'codigoProducto': _codigoProductoController.text,
            'realizoCompra': _realizoCompra,
          });

          // Mostrar un cuadro de diálogo personalizado
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('¡Gracias por participar!',
                    style: TextStyle(color: Colors.white)),
                content:
                    Text('Suerteeeeee', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.lightBlue, // Fondo azul cielo
                actions: <Widget>[
                  TextButton(
                    child:
                        Text('Cerrar', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );

          // Limpiar los campos del formulario
          _nombreController.clear();
          _cedulaController.clear();
          _telefonoController.clear();
          _emailController.clear();
          _codigoProductoController.clear();
        } catch (e) {
          print('Error al guardar los datos: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage()), // Asegúrate de tener una HomePage definida
              );
            },
            child: Image.asset(
              'images/logo2.png',
            ), // Asegúrate de tener esta imagen en tu carpeta assets
          ),
          onPressed: () {
            // Lógica para ir a la página de inicio
          },
        ),
        actions: [
          if (MediaQuery.of(context).size.width > 600) ...[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MecanicaPage()),
                );
              },
              child: Text(
                'Mecánica',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BaseLegalPage()),
                );
              },
              child: Text(
                'Base Legal',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiasDelSorteoPage()),
                );
              },
              child: Text(
                'Días del Sorteo',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
          ] else ...[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.lightBlue, // Fondo azul claro
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Eliminamos el DrawerHeader y la línea divisoria
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('Mecánica', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MecanicaPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.gavel, color: Colors.white),
                title:
                    Text('Base Legal', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BaseLegalPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.white),
                title: Text('Días del Sorteo',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DiasDelSorteoPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/fond.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: 20,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/promo.png',
                height: 350,
                width: 350,
              ),
            ),
          ),
          Positioned(
            left: 180,
            bottom: 150,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/lapiz.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
          Positioned(
            left: 100,
            bottom: -100,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/regla.png',
                height: 300,
                width: 300,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 250,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 100), // Espacio para el AppBar
                        Text(
                          'Regístrate aquí',
                          style: TextStyle(
                            color: Colors.white, // Texto en blanco
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            fillColor: Colors.white, // Fondo blanco
                            filled: true, // Habilita el fondo blanco
                            hintStyle: TextStyle(
                              color: Colors.grey, // Color de texto gris
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su nombre';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        TextFormField(
                          controller: _cedulaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Cédula',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Mismo radio de borde que el campo Nombre
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Borde verde agua al enfocar
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.white, // Fondo blanco
                            filled: true, // Habilita el fondo blanco
                            hintStyle: TextStyle(
                              color: Colors.grey, // Color de texto gris
                            ), // Texto en blanco
                          ),
                          validator: (value) {
                            if (value == null || value.length != 11) {
                              return 'La cédula no es válida';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        TextFormField(
                          controller: _telefonoController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Número de teléfono',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Mismo radio de borde que el campo Nombre
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Borde verde agua al enfocar
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.white, // Fondo blanco
                            filled: true, // Habilita el fondo blanco
                            hintStyle: TextStyle(
                              color: Colors.grey, // Color de texto gris
                            ), // Texto en blanco
                          ),
                          validator: (value) {
                            if (value == null || value.length != 10) {
                              return 'El número no es válido';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Mismo radio de borde que el campo Nombre
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Borde verde agua al enfocar
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black), // Texto en blanco
                            fillColor: Colors.white, // Fondo blanco
                            filled: true, // Habilita el fondo blanco
                            hintStyle: TextStyle(
                              color: Colors.grey, // Color de texto gris
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su correo electrónico';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        TextFormField(
                          controller: _codigoProductoController,
                          decoration: InputDecoration(
                            labelText: 'Código de producto',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Mismo radio de borde que el campo Nombre
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Borde verde agua al enfocar
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black), // Texto en blanco
                            fillColor: Colors.white, // Fondo blanco
                            filled: true, // Habilita el fondo blanco
                            hintStyle: TextStyle(
                              color: Colors.grey, // Color de texto gris
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el código de producto';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(
                            'Registrate YA!!!',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0D2E69),
                            fixedSize: Size(200, 50),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black,
                          ),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 200,
            top: 100,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/avion.png',
                height: 250,
                width: 250,
              ),
            ),
          ),
          Positioned(
            right: 100,
            top: 250,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/lapiz.png',
                height: 80,
                width: 80,
              ),
            ),
          ),
          Positioned(
            right: 100,
            bottom: 20,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/jugos.png',
                height: 300,
                width: 300,
              ),
            ),
          ),
          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              height: 80,
              
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'images/logo.png', // Asegúrate de tener esta imagen en tu carpeta assets
                        height: 50,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/face.png', // Asegúrate de tener esta imagen en tu carpeta assets
                            height: 44,
                            width: 44,
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            'images/insta.png', // Asegúrate de tener esta imagen en tu carpeta assets
                            height: 44,
                            width: 44,
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            'images/tktk.png', // Asegúrate de tener esta imagen en tu carpeta assets
                            height: 44,
                            width: 44,
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            'images/you.png', // Asegúrate de tener esta imagen en tu carpeta assets
                            height: 44,
                            width: 44,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
          
        ],
      ),
    );
  }
}
