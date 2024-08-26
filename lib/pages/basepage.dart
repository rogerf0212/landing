import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';


class BaseLegalPage extends StatelessWidget {
  const BaseLegalPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0,
          toolbarHeight: 70.0,
          leading: IconButton(
            icon: GestureDetector(
              onTap: () => context.beamToNamed('/home'),
              child: Image.asset('images/logo.png'),
            ),
            onPressed: () {
              // Lógica para ir a la página de inicio
            },
          ),
          actions: [
            if (isWideScreen) ...[
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
            color: Colors.lightBlue,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text('Inicio', style: TextStyle(color: Colors.white)),
                  onTap: () => context.beamToNamed('/home'),
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.white),
                  title:
                      Text('Mecánica', style: TextStyle(color: Colors.white)),
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/oscuro.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: 700), // Tamaño máximo de 700 píxeles
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 100), // Margen lateral
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Alineación desde la parte superior
                  children: [
                    Text(
                      '''El Instituto Nacional de Protección de los Derechos del Consumidor (PRO CONSUMIDOR), en virtud de las disposiciones de la Ley General de Protección de los Derechos del Consumidor o Usuario, No. 358-05, y de la Resolución No. 009-2011 sobre Regulación de Concursos, Rifas y Sorteos en la República Dominicana, dictada por el Consejo Directivo en fecha veinte (20) del mes de octubre del año dos mil once (2011); luego de haber verificado el cumplimiento del procedimiento establecido al efecto, procede a otorgar el presente:

CERTIFICADO DE REGISTRO DE BASES DE CONCURSO, RIFA O SORTEO
Promoción: "VUELVE A CLASES CON SANTAL"
Vigencia: Del 19 de agosto al 30 de septiembre de 2024
Razón Social: VIP PRODUCTIONS G&Y, S.R.L.''',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white, // Texto blanco
                        fontSize: MediaQuery.of(context).size.width < 600
                                ? 18
                                : 26,
                      ),
                    ),
                    SizedBox(height: 20), // Espacio vertical entre los textos
                    Text(
                      '''En consecuencia, autoriza la inscripción de la leyenda 'Registrado por Pro Consumidor bajo el No. CRS-0549/2024'. Sin perjuicio de que el solicitante deba cumplir con otros requisitos o registros adicionales que pudieran ser exigidos por otras instituciones competentes. Dado en Santo Domingo, Distrito Nacional, Capital de la República Dominicana, a los diecinueve (19) del mes de agosto del dos mil veinticuatro (2024).''',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white, // Texto blanco
                        fontSize: MediaQuery.of(context).size.width < 600
                                ? 18
                                : 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
