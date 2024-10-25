import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // Para decodificar las respuestas JSON

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  bool showPasswordRules = false;
  bool showUsernameRules = false;
  bool showNameRules = false;
  bool showSurnameRules = false;
  bool showPhoneRules = false;
  bool showEmailRules = false;

  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialCharacter = false;

  // Actualiza el estado de las validaciones cada vez que el usuario escribe en la contraseña
  void _validatePassword(String password) {
    setState(() {
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasLowerCase = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecialCharacter = password.contains(RegExp(r'[$;._\-*]'));
      showPasswordRules = password.isNotEmpty;
    });
  }

  // Función para registrar al usuario en la API
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Muestra un indicador de carga mientras se realiza la solicitud
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Procesando...')),
      );

      try {
        final response = await http.post(
          Uri.parse('URL_DE_TU_API/register'), // Reemplaza con la URL de tu API
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'username': _usernameController.text,
            'name': _nameController.text,
            'surname': _surnameController.text,
            'phone': _phoneController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registro exitoso')),
          );
          // Aquí puedes navegar a otra pantalla si lo deseas
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error en el registro')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
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
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de Usuario',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      showUsernameRules = value.isNotEmpty;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu nombre de usuario';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return 'El nombre de usuario solo puede contener letras y números';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                if (showUsernameRules)
                  const Text(
                    'El nombre de usuario solo puede contener letras y números.',
                    style: TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 20),

                // Campo para Nombre
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu nombre';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'El nombre solo puede contener letras';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Campo para Apellidos
                TextFormField(
                  controller: _surnameController,
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tus apellidos';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Los apellidos solo pueden contener letras y espacios';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Campo para Teléfono
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu número de teléfono';
                    }
                    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                      return 'Introduce un número de teléfono válido (7 a 15 dígitos)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Campo para Correo Electrónico
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu correo electrónico';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Introduce un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Campo para Contraseña
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  onChanged: _validatePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce una contraseña';
                    }
                    if (!hasUpperCase || !hasLowerCase || !hasNumber || !hasSpecialCharacter) {
                      return 'Por favor, asegúrate de que la contraseña cumple todos los requisitos.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                if (showPasswordRules)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '- Una letra mayúscula',
                        style: TextStyle(
                          color: hasUpperCase ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        '- Una letra minúscula',
                        style: TextStyle(
                          color: hasLowerCase ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        '- Un número',
                        style: TextStyle(
                          color: hasNumber ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        '- Un símbolo (\$ ;._-*\'\\)',
                        style: TextStyle(
                          color: hasSpecialCharacter ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),

                // Botón de registro
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
