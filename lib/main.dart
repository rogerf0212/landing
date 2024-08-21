import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:landing/pages/colreg.dart';
import 'package:landing/pages/dashboard_screan.dart';
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
        'mecanica-col'
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('home'),
        title: 'Home',
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
      if (state.uri.pathSegments.contains(''))
        const BeamPage(
          key: ValueKey('mecanica-col'),
          title: 'mecanica-col',
          child: MecanicaPage(),
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
                image: AssetImage('images/fond.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
         Positioned(
            left: screenWidth / 2 - 0.10 * screenWidth,
            top: 0.12 * screenHeight,
            child: Visibility(
              visible: screenWidth > 600,
              child: Image.asset(
                'images/promo.png',
                height: 0.17 * screenHeight,
                width: 0.17 * screenWidth,
              ),
            ),
          ),
          Positioned(
            left: 0.03 * screenWidth,
            top: 20,
            child: Visibility(
              visible: screenWidth > 600,
              child: Image.asset(
                'images/logo.png',
                height: 0.15 * screenHeight,
                width: 0.15 * screenWidth,
              ),
            ),
          ),
          Positioned(
            left: screenWidth / 2 - 0.1 * screenWidth,
            top: 20,
            child: Visibility(
              visible: screenWidth < 600,
              child: Image.asset(
                'images/promo.png',
                height: 0.18 * screenHeight,
                width: 0.18 * screenWidth,
              ),
            ),
          ),
          Positioned(
            left: 0.004 * screenWidth,
            bottom: 0.15 * screenHeight,
            child: Visibility(
              visible: screenWidth > 600,
              child: Image.asset(
                'images/lapiz.png',
                height: 0.28 * screenHeight,
                width: 0.28 * screenWidth,
              ),
            ),
          ),
          Positioned(
            left: 0.05 * screenWidth,
            bottom: -0.1 * screenHeight,
            child: Visibility(
              visible: screenWidth > 600,
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
              
              crossAxisAlignment: CrossAxisAlignment.center, // Alineamos los elementos al centro
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: '\n¡Prepárate para ganar increíbles premios!\n\n\n\n\n',
          style: TextStyle(
            fontSize: 0.022 * screenWidth,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: 'Y participa por la oportunidad de llevarte bonos de compras en\n supermercados, canastas de productos Induveca, laptops y tablets.\n\n',
          style: TextStyle(
            fontSize: 0.022 * screenWidth,
            color: Colors.white,
          ),
        ),
        TextSpan(
          text: 'Regístrate ahora. Selecciona el tipo de establecimiento donde realizaste tu compra:',
          style: TextStyle(
            fontSize: 0.022 * screenWidth,
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
                      fontSize: 0.015 * screenWidth,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D2E69),
                    fixedSize: Size(0.35 * screenHeight, 0.04 * screenWidth,),
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
                      fontSize: 0.015 * screenWidth,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D2E69),
                    fixedSize: Size(0.35 * screenHeight, 0.04 * screenWidth,),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Imagen en la esquina inferior derecha
          Positioned(
            right: -0.02 * screenWidth,
            top: 0.05 * screenHeight,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/avion.png',
                height: MediaQuery.of(context).size.height * 0.40, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.40,
              ),
            ),
          ),
          Positioned(
            right: -0.02 * screenWidth,
            top: 0.55 * screenHeight,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/lapiz.png',
                height: MediaQuery.of(context).size.height * 0.18, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.18,
              ),
            ),
          ),
          Positioned(
            right: 100,
            bottom: 0,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/pre1.png',
                height: MediaQuery.of(context).size.height * 0.45, // 60% del alto de la pantalla
               width: MediaQuery.of(context).size.width * 0.45,
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
