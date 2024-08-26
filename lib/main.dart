import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:landing/pages/basepage.dart';
import 'package:landing/pages/colreg.dart';
import 'package:landing/pages/dashboard_screan.dart';
import 'package:landing/pages/diasort.dart';
import 'package:landing/pages/mecapagesup.dart';
import 'package:landing/pages/mecpage.dart';
import 'package:landing/pages/supreg.dart';
import 'package:beamer/beamer.dart';

class LandingLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        '/dashboard',
        '/home',
        '/registro-colmado',
        '/registro-super',
        '/mecanica-col',
        '/mecanica-super',
        '/dia-sorteo',
        '/base-legal'
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('home'),
        title: 'PromoSantal',
        child: HomePage(),
      ),
      if (state.uri.pathSegments.contains('dashboard'))
        const BeamPage(
          key: ValueKey('dashboard'),
          title: 'dashboard',
          child: DashboardScreen(),
        ),
      if (state.uri.pathSegments.contains('registro-colmado'))
        const BeamPage(
          key: ValueKey('registro-colmado'),
          title: 'registro-colmado',
          child: RegistroColmado(),
        ),
      if (state.uri.pathSegments.contains('registro-super'))
        const BeamPage(
          key: ValueKey('registro-super'),
          title: 'registro-super',
          child: RegistroSupermercado(),
        ),
      if (state.uri.pathSegments.contains('mecanica-col'))
        const BeamPage(
          key: ValueKey('mecanica-col'),
          title: 'mecanica-col',
          child: MecanicaPage(),
        ),
        if (state.uri.pathSegments.contains('mecanica-super'))
        const BeamPage(
          key: ValueKey('mecanica-super'),
          title: 'mecanica-super',
          child: MecanicasupPage(),
        ),
        if (state.uri.pathSegments.contains('dia-sorteo'))
        const BeamPage(
          key: ValueKey('dia-sorteo'),
          title: 'dia-sorteo',
          child: DiasDelSorteoPage(),
        ),
        if (state.uri.pathSegments.contains('base-legal'))
        const BeamPage(
          key: ValueKey('base-legal'),
          title: 'base-legal',
          child: BaseLegalPage(),
        ),
    ];
    final String? landingIdParameter = state.pathParameters['landingId'];
    if (landingIdParameter != null) {
      final landingId = int.tryParse(landingIdParameter);
      pages.add(
        BeamPage(
          child: DashboardScreen(),
        ),
      );
    }
    return pages;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBn1l8EL2fFJ9BrancAttotBlu5dCoor_A",
          projectId: "landing-7f255",
          storageBucket: "landing-7f255.appspot.com",
          messagingSenderId: "442245938168",
          appId: "1:442245938168:web:d027dd0b73882c57c2340d",
          measurementId: "G-W7EGTGY3ZY")); // Inicializa Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [LandingLocation()],
    ),
    notFoundRedirectNamed: '/home',
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/oscuro.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: screenWidth / 2 - 140,
            top: 50,
            child: Visibility(
              visible: screenWidth > 1000,
              child: Image.asset(
                'images/promo.png',
                height: 350,
                width: 350,
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 40,
            child: Visibility(
              visible: screenWidth > 1000,
              child: Image.asset(
                'images/logo.png',
                height: 250,
                width: 250,
              ),
            ),
          ),
          Positioned(
            left: screenWidth / 2 - 100,
            top: 60,
            child: Visibility(
              visible: screenWidth < 600,
              child: Image.asset(
                'images/promo.png',
                height: 210,
                width: 210,
              ),
            ),
          ),
          Positioned(
            left: 0.08 * screenWidth,
            bottom: 0.15 * screenHeight,
            child: Visibility(
              visible: screenWidth > 1000,
              child: Image.asset(
                'images/lapiz.png',
                height: 0.18 * screenHeight,
                width: 0.18 * screenWidth,
              ),
            ),
          ),
          Positioned(
            left: 0.05 * screenWidth,
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
          // Contenido con espaciado lateral
          Center(
            // Agregamos un Center widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Alineamos los elementos al centro
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '\n\n¡Prepárate para ganar increíbles premios!\n\n\n\n\n',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 22
                                : 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '\nY participa por la oportunidad de llevarte bonos de compras en\n supermercados, canastas de productos Induveca, laptops y tablets.\n\n',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 36,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Regístrate ahora. Selecciona el tipo de establecimiento donde realizaste tu compra:',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 36,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => context.beamToNamed('/registro-colmado'),
                  child: Text(
                    'Colmado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D2E69),
                    fixedSize: Size(250, 60),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.beamToNamed('/registro-super'),
                  child: Text(
                    'Supermercado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D2E69),
                    fixedSize: Size(250, 60),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Imagen en la esquina inferior derecha
          Positioned(
            right: 50,
            top: 00,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  1000, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/avion.png',
                height: MediaQuery.of(context).size.height *
                    0.40, // 60% del alto de la pantalla
                width: MediaQuery.of(context).size.width * 0.40,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 220,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  1000, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/lapiz.png',
                height: MediaQuery.of(context).size.height *
                    0.18, // 60% del alto de la pantalla
                width: MediaQuery.of(context).size.width * 0.18,
              ),
            ),
          ),
          Positioned(
            right: 100,
            bottom: 0,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  1000, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/pre1.png',
                height: MediaQuery.of(context).size.height *
                    0.40, // 60% del alto de la pantalla
                width: MediaQuery.of(context).size.width * 0.40,
              ),
            ),
          ),
          Positioned(
            right: 100,
            left: 100,
            bottom: -50,
            child: Visibility(
              visible: MediaQuery.of(context).size.width <
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/pre1.png',
                height: 250,
                width: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
