import 'package:dependency_injector/dependency_injector.dart';
import 'package:dependency_injector/dependency_injector_test.dart';
import 'package:example/services.dart';
import 'package:example/tabs/variants_tab.dart';
import 'package:example/tabs/variants_tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockScoped62 extends Mock implements Scoped62 {}

void main() {
  final newServices = replaceWithMock(
    services: services,
    mockServices: [
      ParameterizedScoped<Scoped62, int>((p) {
        final mockScoped62 = MockScoped62();

        when(mockScoped62.value).thenReturn(100500);

        return mockScoped62;
      }),
    ],
  );

  testWidgets('Variants tab Injector 5', (tester) async {
    await tester.pumpWidget(
      RootInjector(
        services: newServices,
        child: MaterialApp(
          home: Scaffold(
            body: Injector(() => Scope4(name: 'Injector 5:')),
          ),
        ),
      ),
    );

    expect(find.text('100500'), findsOneWidget);
  });
}
