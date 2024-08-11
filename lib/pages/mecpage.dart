import 'package:flutter/material.dart';
import 'package:landing/main.dart';
import 'package:landing/pages/basepage.dart';
import 'package:landing/pages/diasort.dart';

class MecanicaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()), // Asegúrate de tener una HomePage definida
              );
            },
            child: Image.asset('assets/logo.png'), // Asegúrate de tener esta imagen en tu carpeta assets
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
                title: Text('Base Legal', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BaseLegalPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.white),
                title: Text('Días del Sorteo', style: TextStyle(color: Colors.white)),
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
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fondo.png'), // Asegúrate de tener esta imagen en tu carpeta assets
            fit: BoxFit.cover, // La imagen ocupará todo el ancho de la pantalla
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80), // Separación del AppBar
                Text(
                  'Promo en Colmados',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                // Agregar espacio entre las imágenes
              SizedBox(height: 16),
              Text(
                'Premios',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bonos de compra en supermercados', style: TextStyle(color: Colors.white)),
                  Text('Canasta de productos Induveca', style: TextStyle(color: Colors.white)),
                  Text('Laptops', style: TextStyle(color: Colors.white)),
                  Text('Tablets', style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 16),
              Text(
  '¡No te pierdas la oportunidad de ganar estos increíbles premios y comenzar el regreso a clases con todo lo que necesitas gracias a Santal!',
  style: TextStyle(
    fontStyle: FontStyle.italic,
    color: Colors.white,
  ),
),
SizedBox(height: 32), // Espacio adicional
Text(
  'Pasos para participar:',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
),
SizedBox(height: 16),
Row(
  children: [
    Image.asset(
      'images/logo.png', // Asegúrate de tener esta imagen en tu carpeta assets
      width: 24,
      height: 24,
    ),
    SizedBox(width: 8),
    Text(
      'Adquiere cualquier sabor y Formato de la marca Santal', // Texto "Adquiere cualquier sabor"
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    
  ],
),
SizedBox(height: 16),
Row(
  children: [
    Image.asset(
      'images/logo.png', // Asegúrate de tener esta imagen en tu carpeta assets
      width: 24,
      height: 24,
    ),
    SizedBox(width: 8),
    Text(
      'Entra a nuestra página web promosantal.com y registra el código del producto', // Texto "Entra a nuestra página web promosantal.com y registra el código del producto"
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ],
),
SizedBox(height: 16),
Row(
  children: [
    Image.asset(
      'images/logo.png', // Asegúrate de tener esta imagen en tu carpeta assets
      width: 24,
      height: 24,
    ),
    SizedBox(width: 8),
    Text(
      'Conserva el empaque de tu producto, ya que será necesario si resultas ganador', // Texto "Conserva el empaque de tu producto, ya que será necesario si resultas ganador"
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ],
),
SizedBox(height: 16),
Row(
  children: [
    Image.asset(
      'images/logo.png', // Asegúrate de tener esta imagen en tu carpeta assets
      width: 24,
      height: 24,
    ),
    SizedBox(width: 8),
    Text(
      'Prepárate para ser uno de los próximos ganadores', // Texto "Prepárate para ser uno de los próximos ganadores"
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    SizedBox(height: 20),
                // Agregar la primera imagen aquí
                Image.asset(
                  'images/p1.png', // Asegúrate de tener esta imagen en tu carpeta assets
                  width: 200,
                  height: 300,
                ),
                // Agregar espacio entre las imágenes
                SizedBox(height: 20),
                // Agregar la segunda imagen aquí
                Image.asset(
                  'images/p2.png', // Asegúrate de tener esta imagen en tu carpeta assets
                  width: 200,
                  height: 300,
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