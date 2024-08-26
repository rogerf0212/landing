import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';


class MecanicaPage extends StatelessWidget {
  
  const MecanicaPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
              onPressed: () => context.beamToNamed('/mecanica-col'),
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
                onTap: () => context.beamToNamed('/mecanica-col'),
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
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/oscuro.png'),
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
                          'Promo en colmados',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 46,
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
                                : 46,
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
                                        : 26,
                              ),
                            ),
                            Text(
                              '- Canasta de productos induveca',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 26,
                              ),
                            ),
                            Text(
                              '- Laptops',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 26,
                              ),
                            ),
                            Text(
                              '- Tablets',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 26,
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
                                : 26,
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
                                : 46,
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
                              'Adquiere cualquier sabor y formato de la marca Santal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 20,
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
                              'Entra a nuestra página web\ny promosantal.com y registra el código\ny del producto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 20,
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
                              'Conserva el empaque de tu producto ya\nque será necesario si resultas ganador.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 8
                                        : 20,
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
                                        : 20,
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
            top: 50,
            left: 400,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/pre1.png',
                height: 0.5 * screenHeight,
                width: 0.4 * screenWidth,
              ),
            ),
          ),
          Positioned(
            bottom: -200,
            left: 300,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/p2.png',
                height: 0.6 * screenHeight,
                width: 0.5 * screenWidth,
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
                height: 0.6 * screenHeight,
                width: 0.5 * screenWidth,
              ),
            ),
          ),
          Positioned(
            right: 480,
            top: 50,
            child: Visibility(
              visible: screenWidth > 1000,
              child: Image.asset(
                'images/promo.png',
                height: 400,
                width: 400,
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 100,
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 600,
              child: Image.asset(
                'images/lapiz.png',
                height: 0.18 * screenHeight,
                width: 0.18 * screenWidth,
              ),
            ),
          ),
          Positioned(
            right: 0.05 * screenWidth,
            bottom: -0.15 * screenHeight,
            child: Visibility(
              visible: screenWidth > 1000,
              child: Image.asset(
                'images/regla.png',
                height: 0.5 * screenHeight,
                width: 0.4 * screenWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
