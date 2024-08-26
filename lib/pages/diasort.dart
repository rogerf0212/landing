import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';


class DiasDelSorteoPage extends StatelessWidget {
  
  const DiasDelSorteoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
            left: screenWidth / 2 - 155,
            top: 60,
            child: Visibility(
              visible: screenWidth < 600,
              child: Image.asset(
                'images/promo.png',
                height: 310,
                width: 310,
              ),
            ),
          ),
          Positioned(
            right: 100,
            left: 100,
            bottom: 0,
            child: Visibility(
              visible: MediaQuery.of(context).size.width <
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/pre1.png',
                height: 350,
                width: 350,
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
                'images/pre1.png',
                height: MediaQuery.of(context).size.height *
                    0.50, // 60% del alto de la pantalla
                width: MediaQuery.of(context).size.width * 0.50,
              ),
            ),
          ),
    Center(
      child: Container(
        width: 700,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(50), // Esquinas ovaladas
          border: Border.all(color: Colors.black), // Borde negro
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // Efecto de sombreado y elevación
            ),
          ],
        ),
        child: Center(
          child: Text(
            'El sorteo será el día 1ro de Noviembre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ],
)




    );
  }
}
