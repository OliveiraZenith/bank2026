// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bank/main.dart';

void main() {
  testWidgets('exibe vagas iniciais e adiciona um estacionamento', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BankApp());

    expect(find.text('Estacionamento'), findsOneWidget);
    expect(find.text('Vaga 2'), findsOneWidget);
    expect(find.text('Vaga 5'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), '12');
    await tester.enterText(find.byType(TextField).at(1), '25,50');
    await tester.tap(find.text('Confirmar'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Vaga 12'), findsOneWidget);
  });
}
