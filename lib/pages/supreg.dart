import 'package:beamer/beamer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:landing/pages/send.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistroSupermercado extends StatefulWidget {
  const RegistroSupermercado({Key? key}) : super(key: key);
  @override
  _RegistroSupermercadoState createState() => _RegistroSupermercadoState();
}

class _RegistroSupermercadoState extends State<RegistroSupermercado> {
  @override
  bool _mostrarImagen = true;
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

  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF0D2E69),
          title: Text(
            'Error',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          content: Text(
              'La imagen no se ha cargado. Por favor, seleccione una imagen.',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Aceptar',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        );
      },
    );
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

  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible:
            false, // Evita que el usuario cierre el cuadro de diálogo
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: 150,
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            backgroundColor: Colors.lightBlue,
          );
        },
      );

      // Consulta Firestore para verificar si el código de producto ya existe
      final existingProduct = await FirebaseFirestore.instance
          .collection('registros')
          .where('codigoProducto', isEqualTo: _codigoProductoController.text)
          .get();

      if (_selectedImage == null) {
        _mostrarAlerta(context);
      } else {
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
        } else {
          // Subir la imagen a Firebase Storage (si hay una imagen seleccionada)
          if (_selectedImage != null) {
            final storageRef = FirebaseStorage.instance
                .ref()
                .child('images/${_codigoProductoController.text}.jpg');

            try {
              await storageRef.putData(_selectedImage!.bytes!);
              final downloadUrl = await storageRef.getDownloadURL();
              print('Imagen subida con éxito. URL: $downloadUrl');
            } catch (e) {
              print('Error al subir la imagen: $e');
            }
          }

        // var Notemp = 32200000;
         //String Noparticipacion = Notemp.toString();
         //const subj = 'Promo Santal';
         // String mess =
            //  'Ya estas registrado para el Sorteo, recuerda entrar a nuestra pagina el dia 1ro de Noviembre para ver si eres uno de los Ganadores!\n tu codigo de registro es: $Noparticipacion';

         // await SendEmailService.sendMail(
           //   email: _emailController.text,
            //  name: _nombreController.text,
            //  subject: subj,
            //  message: mess);

          // Guardar los datos en Firestore
          try {
            await FirebaseFirestore.instance.collection('registros').add({
              'nombre': _nombreController.text,
              'NodeIdentidad': _cedulaController.text,
              'telefono': _telefonoController.text,
              'email': _emailController.text,
              'codigoProducto': _codigoProductoController.text,
              'realizoCompra': _realizoCompra,
              //'Noparticipacion': Noparticipacion,
            });

            Navigator.of(context).pop();

            // Mostrar un cuadro de diálogo personalizado
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('¡Tu registro ha sido exitoso!',
                      style: TextStyle(color: Colors.white)),
                  content: Text(
                      'Te deseamos mucha suerte. No olvides visitar nuestra página el\n 1ero de Noviembre para conocer si eres uno de los ganadores.\n \n ¡Gracias por participar!',
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
           setState(() {
             _selectedImage = null;
           });
           // Notemp = Notemp + 1;
           // print(Noparticipacion);
          } catch (e) {
            print('Error al guardar los datos: $e');
          }
        }
      }
    }
  }

  bool esDireccionValida(String email) {
    final RegExp regex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
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
            onTap: () => context.beamToNamed('/home'),
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
              onPressed: () => context.beamToNamed('/home'),
              child: Text(
                'Inicio',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () => context.beamToNamed('/mecanica-super'),
              child: Text(
                'Mecánica',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () => context.beamToNamed('/base-legal'),
              child: Text(
                'Base Legal',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () => context.beamToNamed('/dia-sorteo'),
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
                leading: Icon(Icons.home, color: Colors.white),
                title: Text('Inicio', style: TextStyle(color: Colors.white)),
                onTap: () => context.beamToNamed('/home'),
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('Mecánica', style: TextStyle(color: Colors.white)),
                onTap: () => context.beamToNamed('/mecanica-super'),
              ),
              ListTile(
                leading: Icon(Icons.gavel, color: Colors.white),
                title:
                    Text('Base Legal', style: TextStyle(color: Colors.white)),
                onTap: () => context.beamToNamed('/base-legal'),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.white),
                title: Text('Días del Sorteo',
                    style: TextStyle(color: Colors.white)),
                onTap: () => context.beamToNamed('/dia-sorteo'),
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
                image: AssetImage('images/oscuro.png'),
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
                height: MediaQuery.of(context).size.height *
                    0.33, // 60% del alto de la pantalla
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
                height: MediaQuery.of(context).size.height *
                    0.18, // 60% del alto de la pantalla
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
                height: MediaQuery.of(context).size.height *
                    0.40, // 60% del alto de la pantalla
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
                height: MediaQuery.of(context).size.height *
                    0.50, // 60% del alto de la pantalla
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
                height: MediaQuery.of(context).size.height *
                    0.18, // 60% del alto de la pantalla
                width: MediaQuery.of(context).size.width * 0.18,
              ),
            ),
          ),
          Positioned(
  right: 50,
  bottom: 0,
  child: Visibility(
    visible: true, // Mantén siempre visible la imagen
    child: LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Ajusta las dimensiones de la imagen según la pantalla
        final imageHeight = screenHeight * 0.50;
        final imageWidth = screenWidth * 0.50;

        return Image.asset(
          'images/jugos.png',
          height: imageHeight,
          width: imageWidth,
        );
      },
    ),
  ),
),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent, // Color de fondo transparente
                height: 80, // Altura del footer
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'images/logo.png', // Asegúrate de tener esta imagen en tu carpeta assets
                      height: 50,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            launch(
                                'https://www.instagram.com/santalrd?igsh=cjE0bXo2Nm9zeDQ5');
                          },
                          child: Image.asset(
                            'images/insta.png',
                            height: 44,
                            width: 44,
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              )),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 300,
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
                              color: Colors.grey,
                              // Color de texto gris
                            ),
                            errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 73, 245, 85),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  14, // Cambia el color del mensaje de error
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
                            labelText: 'No. de Identidad',
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
                            ),
                            errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 73, 245, 85),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  14, // Cambia el color del mensaje de error
                            ), // Texto en blanco
                          ),
                          validator: (value) {
                            if (value == null || value.length < 5) {
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
                            ),
                            errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 73, 245, 85),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  14, // Cambia el color del mensaje de error
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
                            errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 73, 245, 85),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  14, // Cambia el color del mensaje de error
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su correo electrónico';
                            } else if (!esDireccionValida(value)) {
                              return 'Ingrese una dirección de correo válida';
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
                                  labelText: 'Código del producto',
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
                                  errorStyle: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 73, 245, 85),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        14, // Cambia el color del mensaje de error
                                  ),
                                  // ... otras propiedades de decoración ...
                                ),
                                validator: (value) {
                                  if (value == null || value.length != 14) {
                                    return 'Por favor ingrese el código de la factura';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: pickImage,
                              child: Row(
                                children: [
                                  Text(
                                    'Subir factura',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ],
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
        ],
      ),
    );
  }
}
