import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:landing/pages/basepage.dart';
import 'package:landing/pages/diasort.dart';
import 'package:landing/pages/mecpage.dart';
import 'dart:typed_data';
import 'database_helper.dart';
import 'colmado.dart';    
      
      class RegistroColmado extends StatefulWidget {
  @override
  _RegistroColmadoState createState() => _RegistroColmadoState();
}

class _RegistroColmadoState extends State<RegistroColmado> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _imageBytes;
  String? _fileName;
  final _nombreController = TextEditingController();
  final _cedulaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _codigoProductoController = TextEditingController();

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageBytes = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Colmado colmado = Colmado(
        nombre: _nombreController.text,
        cedula: _cedulaController.text,
        telefono: _telefonoController.text,
        email: _emailController.text,
        codigoProducto: _codigoProductoController.text,
        imagen: _imageBytes!,
      );
      await DatabaseHelper().insertColmado(colmado);
      // Mostrar un mensaje de éxito o redirigir a otra página
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/logo.png'), // Asegúrate de tener esta imagen en tu carpeta assets
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Mecánica'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MecanicaPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.gavel),
              title: Text('Base Legal'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BaseLegalPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Días del Sorteo'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiasDelSorteoPage()),
                );
              },
            ),
          ],
        ),
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
                          controller: _nombreController,
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
                          controller: _cedulaController,
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
  controller: _telefonoController,
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
  controller: _emailController,
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
  controller: _codigoProductoController,
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
