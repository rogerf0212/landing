import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:landing/pages/colreg.dart';
import 'package:landing/pages/dash.dart';
import 'package:landing/pages/dashboard_screan.dart';
import 'package:landing/pages/supreg.dart';
import 'package:go_router/go_router.dart';
import 'package:beamer/beamer.dart';

class LandingLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/dashboard'];

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
          // Contenido con espaciado lateral
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen en la esquina superior izquierda
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    'images/promo.png',
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width *
                        0.2, // Ajusta la altura también
                  ),
                ),

                // Centra el texto y los botones
                Center(
                  child: Column(
                    children: [
                      Text(
                        '¿En qué tipo de establecimiento realizó su compra?',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistroColmado()),
                          );
                        },
                        child: Text(
                          'Colmado',
                          style: TextStyle(
                            color: Colors
                                .white, // Cambiamos el color del texto a blanco
                            fontWeight:
                                FontWeight.bold, // Hacemos que el texto resalte
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(
                              0xFF93E9BE), // Cambiamos el color de fondo a verde océano
                          fixedSize: Size(200, 50),
                          elevation: 5,
                          shadowColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistroSupermercado()),
                          );
                        },
                        child: Text(
                          'Supermercado',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF93E9BE), // Verde marino
                          fixedSize: Size(200, 50),
                          elevation: 5,
                          shadowColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Imagen en la esquina inferior derecha
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'images/jugos.png',
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
