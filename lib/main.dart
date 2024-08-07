import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:landing/pages/colreg.dart';
import 'package:landing/pages/dash.dart';
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
          child: DashboardPage(),
        ),
    ];
    final String? landingIdParameter = state.pathParameters['landingId'];
    if (landingIdParameter != null) {
      final landingId = int.tryParse(landingIdParameter);
      pages.add(
        BeamPage(
          child: DashboardPage(),
        ),
      );
    }
    return pages;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
  options: const FirebaseOptions(
  apiKey: "AIzaSyBn1l8EL2fFJ9BrancAttotBlu5dCoor_A",
  authDomain: "landing-7f255.firebaseapp.com",
  projectId: "landing-7f255",
  storageBucket: "landing-7f255.appspot.com",
  messagingSenderId: "442245938168",
  appId: "1:442245938168:web:d027dd0b73882c57c2340d",
  measurementId: "G-W7EGTGY3ZY"
  )
 ); // Inicializa Firebase
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
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/fondo.png'), // Asegúrate de tener esta imagen en tu carpeta assets
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      MaterialPageRoute(builder: (context) => RegistroColmado()),
                    );
                  },
                  child: Text('Colmado'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                  child: Text('Supermercado'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(200, 50),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
