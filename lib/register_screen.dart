import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // Variable para controlar la visibilidad de la contraseña

  // Expresión regular para validar la seguridad de la contraseña
  final String passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$;._\-*]).{8,}$';

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

                // Campo para Nombre
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu nombre';
                    }
                    // Validación para permitir solo letras
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'El nombre solo puede contener letras';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo para Apellidos
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tus apellidos';
                    }
                    // Validación para permitir solo letras
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Los apellidos solo pueden contener letras';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo para Teléfono
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu número de teléfono';
                    }
                    // Validación básica de número de teléfono
                    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                      return 'Introduce un número de teléfono válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo para Correo Electrónico
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu correo electrónico';
                    }
                    // Validación básica del formato del correo
                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Introduce un correo electrónico válido';
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

                // Botón de Registro
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Si el formulario es válido, puedes realizar acciones como el registro
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registro exitoso')),
                      );
                    }
                  },
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
