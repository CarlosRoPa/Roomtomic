import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Variables para mostrar u ocultar las validaciones dinámicas
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
      showPasswordRules = password.isNotEmpty; // Muestra las reglas si empieza a escribir
    });
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
                    // Validación para permitir solo letras y números
                    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return 'El nombre de usuario solo puede contener letras y números';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                if (showUsernameRules)
                  Text(
                    'El nombre de usuario solo puede contener letras y números.',
                    style: TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 20),

                // Campo para Nombre
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      showNameRules = value.isNotEmpty;
                    });
                  },
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
                const SizedBox(height: 10),

                if (showNameRules)
                  Text(
                    'El nombre solo puede contener letras.',
                    style: TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 20),

                // Campo para Apellidos (permitiendo espacios entre apellidos)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      showSurnameRules = value.isNotEmpty;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tus apellidos';
                    }
                    // Validación para permitir letras y espacios
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Los apellidos solo pueden contener letras y espacios';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                if (showSurnameRules)
                  Text(
                    'Los apellidos solo pueden contener letras y espacios.',
                    style: TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 20),

                // Campo para Teléfono
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      showPhoneRules = value.isNotEmpty;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu número de teléfono';
                    }
                    // Nueva validación para números de teléfono con o sin prefijo
                    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                      return 'Introduce un número de teléfono válido (7 a 15 dígitos)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                if (showPhoneRules)
                  Text(
                    'Introduce un número de teléfono válido (7 a 15 dígitos).',
                    style: TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 20),

                // Campo para Correo Electrónico
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      showEmailRules = value.isNotEmpty;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu correo electrónico';
                    }
                    // Nueva validación para correos electrónicos más flexible
                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Introduce un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                if (showEmailRules)
                  Text(
                    'Introduce un correo electrónico válido.',
                    style: TextStyle(color: Colors.grey),
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
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  onChanged: _validatePassword,  // Llama a _validatePassword en cada cambio
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
