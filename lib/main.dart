import 'package:flutter/material.dart';
import 'login_screen.dart';  // Asegúrate de que la ruta del archivo esté correcta.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);  // Usa key para la compatibilidad.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoomTomic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),  // Inicializa la pantalla de carga.
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);  // Usa key para la compatibilidad.

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      // Navega a LoginScreen después de un delay de 5 segundos.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),  // Quita el 'const'
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),  // Fondo blanco para la pantalla de carga.
      body: Center(
        child: Image.asset('assets/logo.png'), // Muestra el logo en el centro.
      ),
    );
  }
}
