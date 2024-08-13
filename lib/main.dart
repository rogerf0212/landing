import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:landing/pages/colreg.dart';
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
           Positioned(
            left: 50,
            top: -50,
            child: Visibility(
               // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/promo.png',
                height: 300,
                width: 300,
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
                height: 100,
                width: 100,
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
                height: 300,
                width: 300,
              ),
            ),
          ),
          // Contenido con espaciado lateral
           Center( // Agregamos un Center widget
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.center, // Alineamos los elementos al centro
        children: [
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '¿En qué tipo de establecimiento realizó su compra?',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistroColmado()),
              );
            },
            child: Text(
              'Colmado',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0D2E69),
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
                MaterialPageRoute(builder: (context) => RegistroSupermercado()),
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
              backgroundColor: Color(0xFF0D2E69),
              fixedSize: Size(200, 50),
              elevation: 5,
              shadowColor: Colors.black,
            ),
          ),
        ],
      ),
    ),
          
          // Imagen en la esquina inferior derecha
           Positioned(
            right: 200,
            top: 50,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/avion.png',
                height: 300,
                width: 300,
              ),
            ),
          ),
          Positioned(
            right: 100,
            top: 200,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidades
              child: Image.asset(
                'images/lapiz.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
          Positioned(
            right: 100,
            bottom: -50,
            child: Visibility(
              visible: MediaQuery.of(context).size.width >
                  600, // Cambia el valor según tus necesidade
              child: Image.asset(
                'images/jugos.png',
                height: 400,
                width: 400,
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
                height: 200,
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
