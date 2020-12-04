import 'package:dependency_injector/dependency_injector.dart';
import 'package:example/services.dart';
import 'package:example/tabs/variants_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Variants tab Injector 5', (tester) async {
    await tester.pumpWidget(
      RootInjector(
        services: services,
        child: MaterialApp(
          home: Scaffold(
            body: Injector(() => Scope4(name: 'Injector 5:')),
          ),
        ),
      ),
    );

    expect(find.text('777'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('778'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('776'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    expect(find.text('777'), findsOneWidget);
  });
}
