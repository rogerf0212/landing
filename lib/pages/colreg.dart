import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class RegistroColmado extends StatefulWidget {
  @override
  _RegistroColmadoState createState() => _RegistroColmadoState();
}

class _RegistroColmadoState extends State<RegistroColmado> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _imageBytes;
  String? _fileName;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageBytes = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Lógica para enviar el formulario junto con la imagen
      // Aquí puedes manejar el envío de los datos del formulario y la imagen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Registro Colmado'),
        actions: [
          TextButton(
            onPressed: () {
              // Lógica para ir a la página de inicio
            },
            child: Text(
              'Inicio',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              // Lógica para ir a la página de Mecánica
            },
            child: Text(
              'Mecánica',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20),
          TextButton(
            onPressed: () {
              // Lógica para ir a la página de Base Legal
            },
            child: Text(
              'Base Legal',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20),
          TextButton(
            onPressed: () {
              // Lógica para ir a la página de Días del Sorteo
            },
            child: Text(
              'Días del Sorteo',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Asegúrate de tener esta imagen en tu carpeta assets
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Cédula',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Número de teléfono',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
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
                          decoration: InputDecoration(
                            labelText: 'Código de producto',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
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
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: Text('Subir imagen'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: Size(200, 50),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black,
                          ),
                        ),
                        if (_imageBytes != null) ...[
                          SizedBox(height: 20),
                          Image.memory(
                            _imageBytes!,
                            height: 100,
                            width: 100,
                          ),
                        ],
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Enviar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: Size(200, 50),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black,
                          ),
                        ),
                        SizedBox(height: 100), // Espacio para el BottomAppBar
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/logo.png', // Asegúrate de tener esta imagen en tu carpeta assets
                  height: 50,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/facebook.png', // Asegúrate de tener esta imagen en tu carpeta assets
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      'assets/instagram.png', // Asegúrate de tener esta imagen en tu carpeta assets
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      'assets/tiktok.png', // Asegúrate de tener esta imagen en tu carpeta assets
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      'assets/youtube.png', // Asegúrate de tener esta imagen en tu carpeta assets
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
