import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:landing/main.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:landing/pages/colmado.dart';
import 'package:landing/pages/basepage.dart';
import 'package:landing/pages/diasort.dart';
import 'package:landing/pages/mecapagesup.dart';
import 'package:landing/pages/mecpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class RegistroSupermercado extends StatefulWidget {
  const RegistroSupermercado({Key? key}) : super(key: key);
  @override
  _RegistroSupermercadoState createState() => _RegistroSupermercadoState();
}

class _RegistroSupermercadoState extends State<RegistroSupermercado> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Mostrar el cuadro de diálogo después de que se cargue la página
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF0D2E69), // Fondo azul
            title: Text(
              'Pasos para participar:',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 600 ? 16 : 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'images/img1.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Adquiere cualquier sabor y formato de la marca Santal.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width < 600 ? 8 : 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'images/img4.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Entra a nuestra página web\npromosantal.com y registra el código\n de tu factura.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width < 600 ? 8 : 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Image.asset(
                      'images/img2.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Sube una foto de la factura de tu compra.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width < 600 ? 8 : 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Image.asset(
                      'images/img3.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Prepárate para ser uno de los próximos\nganadores.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width < 600 ? 8 : 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          );
        },
      );
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cedulaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _codigoProductoController = TextEditingController();
  final String _realizoCompra = 'Realizó la compra en un Supermercado';

  PlatformFile? _selectedImage;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _selectedImage = result.files.single;
      });
    }
  }

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
      // Subir la imagen a Firebase Storage (si hay una imagen seleccionada)
      if (_selectedImage != null) {
        final storageRef = FirebaseStorage.instance.ref().child('images/${_codigoProductoController.text}.jpg');
        

        try {
          await storageRef.putData(_selectedImage!.bytes!);
          final downloadUrl = await storageRef.getDownloadURL();
          print('Imagen subida con éxito. URL: $downloadUrl');
        } catch (e) {
          print('Error al subir la imagen: $e');
        }
      }

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

        final smtpServer = SmtpServer('smtp.gmail.com',
      username: 'induvecavip@gmail.com',
      password: 'Vip2024#');

  final message = Message()
    ..from = Address('induvecavip@gmail.com', 'Promosantal')
    ..recipients.add(_emailController.text)
    ..subject = 'Participación en el concurso'
    ..text = '¡Ya estás participando en el concurso!';

  try {
    final sendReport = await send(message, smtpServer);
    print('Correo electrónico enviado: ${sendReport.toString()}');
  } catch (e) {
    print('Error al enviar el correo electrónico: $e');
  }


        // Mostrar un cuadro de diálogo personalizado
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('¡Tu registro ha sido exitoso!',
                  style: TextStyle(color: Colors.white)),
              content: Text(
                  'Te deseamos mucha suerte. No olvides visitar nuestra página el\n 30 de septiembre para conocer si eres uno de los ganadores.\n \n ¡Gracias por participar!',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
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
                'images/logo.png'), // Asegúrate de tener esta imagen en tu carpeta assets
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
                  MaterialPageRoute(builder: (context) => MecanicasupPage()),
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
                    MaterialPageRoute(builder: (context) => MecanicasupPage()),
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
            top: 100,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/promo.png',
                height: MediaQuery.of(context).size.height * 0.33, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.33,
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
                height: MediaQuery.of(context).size.height * 0.18, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.18,
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
                height: MediaQuery.of(context).size.height * 0.40, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.40,
              ),
            ),
          ),
           Positioned(
            right: 60,
            top: 100,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/avion.png',
                height: MediaQuery.of(context).size.height * 0.50, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.50,
              ),
            ),
          ),
          Positioned(
            right: 60,
            top: 250,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/lapiz.png',
                height: MediaQuery.of(context).size.height * 0.18, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.18,
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 0,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/jugos.png',
                height: MediaQuery.of(context).size.height * 0.50, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.50,
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
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _codigoProductoController,
                                decoration: InputDecoration(
                                  labelText: 'Código de la factura',
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
                                  // ... otras propiedades de decoración ...
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese el código de la factura';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: pickImage,
            ),
            SizedBox(width: 16),
            if (_selectedImage != null)
              Image.memory(
                _selectedImage!.bytes!,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
                          ],
                        ),

                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(
                            'Registrate ahora',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
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
