import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:escaperoomtomic/main.dart';  // Asegúrate de que la ruta del archivo esté correcta.

void main() {
  testWidgets('Carga la pantalla de login después de SplashScreen', (WidgetTester tester) async {
    // Construye la app y espera a que la SplashScreen se muestre.
    await tester.pumpWidget(const MyApp());

    // Verifica que la pantalla de carga (SplashScreen) se está mostrando.
    expect(find.byType(Image), findsOneWidget); // El logo debería estar presente en la SplashScreen

    // Espera a que el splash desaparezca (5 segundos simulados).
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verifica que ahora estamos en la pantalla de login.
    expect(find.text('Inicio de Sesión'), findsOneWidget); // El título de la pantalla de login
    expect(find.text('Iniciar Sesión'), findsOneWidget); // El botón de Iniciar Sesión
  });
}