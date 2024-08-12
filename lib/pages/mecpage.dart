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
            child: Image.asset('images/logo2.png'), // Asegúrate de tener esta imagen en tu carpeta assets
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/fondo3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight, left: 26.0), // Espacio para el AppBar
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      Text(
        'Promo en colmados',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Premios',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('-Bonos de compra en supermercados', style: TextStyle(color: Colors.white)),
          Text('-Canasta de productos induveca', style: TextStyle(color: Colors.white)),
          Text('-Laptops y tablets', style: TextStyle(color: Colors.white)),
          Text('-Tablets', style: TextStyle(color: Colors.white)),
        ],
      ),
      SizedBox(height: 16),
      Text(
        'No te pierdas la oportunidad de ganar estos\ny increíbles premios comenzar el regreso\ny a clases con todo lo que necesitas\ny gracias a Santal.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        textAlign: TextAlign.left, // Alineación a la izquierda
      ),
      SizedBox(height: 16),
      Text(
        'Pasos para participar:',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Image.asset('images/img1.png', width: 30, height: 30), // Reemplaza con la ruta correcta de la imagen
          SizedBox(width: 8),
          Text(
            'Adquiere cualquier sabor y formato de la marca Santal',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Image.asset('images/img2.png', width: 30, height: 30), // Reemplaza con la ruta correcta de la imagen
          SizedBox(width: 8),
          Text(
            'Entra a nuestra pagina web\ny promosantal.com y registra el codigo\ny del producto',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
       SizedBox(height: 8),
      Row(
        children: [
          Image.asset('images/img3.png', width: 30, height: 30), // Reemplaza con la ruta correcta de la imagen
          SizedBox(width: 8),
          Text(
            'Conserva el empaque de tu producto ya\ny que sera necesario si resultas ganador.',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
       SizedBox(height: 8),
      Row(
        children: [
          Image.asset('images/img4.png', width: 30, height: 30), // Reemplaza con la ruta correcta de la imagen
          SizedBox(width: 8),
          Text(
            'Preparate para ser uno de los proximos\ny ganadores!',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      // Agrega más filas de imágenes y texto según sea necesario
    ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}