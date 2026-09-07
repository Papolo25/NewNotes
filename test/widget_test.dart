import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notes/main.dart';

void main() {
  testWidgets('puede crear una nota', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('TODAS MIS NOTAS'), findsOneWidget);
    expect(find.text('No tienes notas todavía'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Crear nota'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Mi nota');
    await tester.enterText(find.byType(TextField).at(1), 'Contenido');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    expect(find.text('Mi nota'), findsOneWidget);
    expect(find.text('Contenido'), findsOneWidget);
  });

  testWidgets('puede editar y eliminar una nota', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Mi nota');
    await tester.enterText(find.byType(TextField).at(1), 'Contenido');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mi nota'));
    await tester.pumpAndSettle();

    expect(find.text('Editar nota'), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(find.text('¿Estás seguro de que quieres eliminar esta nota?'), findsOneWidget);

    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();

    expect(find.text('Mi nota'), findsNothing);
  });

  testWidgets('avisa antes de salir con cambios sin guardar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Nota sin guardar');
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Cambios sin guardar'), findsOneWidget);
    expect(find.text('Tienes cambios sin guardar. ¿Quieres salir sin guardar?'), findsOneWidget);

    await tester.tap(find.text('Seguir editando'));
    await tester.pumpAndSettle();

    expect(find.text('Crear nota'), findsOneWidget);
  });
}
