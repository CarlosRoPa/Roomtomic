import 'package:flutter/material.dart';
import 'register_screen.dart';  // Asegúrate de que la ruta del archivo esté correcta.

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState(); // Cambia el nombre de la clase del estado
}

class LoginScreenState extends State<LoginScreen> { // Haz la clase del estado pública
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // Variable para controlar la visibilidad de la contraseña

  // Expresión regular para validar la seguridad de la contraseña
  final String passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$;._\-*]).{8,}$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Campo para Nombre de Usuario
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre de Usuario',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu nombre de usuario';
                    }
                    // Validación para permitir solo letras y números
                    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return 'El nombre de usuario solo puede contener letras y números';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo para Contraseña
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility // Ícono de ojo cerrado
                            : Icons.visibility_off, // Ícono de ojo abierto
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword; // Cambia el estado al presionar el ícono
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce una contraseña';
                    }
                    // Validación de la contraseña según el patrón
                    if (!RegExp(passwordPattern).hasMatch(value)) {
                      return 'La contraseña debe tener al menos 1 número, 1 mayúscula, 1 minúscula y un símbolo dollar ;._-*';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Botón de Iniciar Sesión
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Si el formulario es válido, puedes realizar acciones como el inicio de sesión
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Inicio de sesión exitoso')),
                      );
                    }
                  },
                  child: const Text('Iniciar Sesión'),
                ),
                
                const SizedBox(height: 20),

                // Botón de Registrarse
                TextButton(
                  onPressed: () {
                    // Navega a la pantalla de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    '¿No tienes una cuenta? Regístrate aquí',
                    style: TextStyle(color: Colors.blue),
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
