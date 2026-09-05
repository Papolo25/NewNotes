import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notes/main.dart';

void main() {
  testWidgets('puede crear una nota', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mis notas'), findsOneWidget);
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
}
