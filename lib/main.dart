import 'package:flutter/material.dart';
import 'package:landing/pages/colreg.dart';
import 'package:landing/pages/dashboard.dart';
import 'package:landing/pages/supreg.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => RegistroColmado(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => Dashboard(),
      ),
    ],
  );


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
