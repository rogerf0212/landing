import 'package:flutter/material.dart';
import 'package:landing/main.dart';
import 'package:landing/pages/basepage.dart';
import 'package:landing/pages/diasort.dart';

class MecanicasupPage extends StatelessWidget {
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
                MaterialPageRoute(builder: (context) => HomePage()), // Asegúrate de tener una HomePage definida
              );
            },
            child: Image.asset('images/logo.png'), // Asegúrate de tener esta imagen en tu carpeta assets
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
                  image: AssetImage('images/fond.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 26.0),
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Promo en Supermercados',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Premios',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '- Bonos de compra en supermercados',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                            Text(
                              '- Canasta de productos induveca',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                            Text(
                              '- Laptops',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                            Text(
                              '- Tablets',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No te pierdas la oportunidad de ganar estos\ny increíbles premios comenzar el regreso\ny a clases con todo lo que necesitas\ny gracias a Santal.',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 8
                                : 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Pasos para participar:',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
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
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                          ],
                        ),
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
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                          ],
                        ),
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
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                          ],
                        ),
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
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 200),
                        // Agrega más filas de imágenes y texto según sea necesario
                      ],
                    ),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 200,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/pre1.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: 400,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/p2.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 400,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/p1.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/avion.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Positioned(
            top: 130,
            right: 300,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/lapiz.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}