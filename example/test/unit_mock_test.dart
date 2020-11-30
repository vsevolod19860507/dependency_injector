import 'package:dependency_injector/dependency_injector.dart';
import 'package:dependency_injector/dependency_injector_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/services.dart';
import 'package:example/tabs/variants_tab_data.dart';
import 'package:mockito/mockito.dart';

class MockTransient66 extends Mock implements Transient66 {}

void main() {
  final newServices = replaceWithMock(
    services: services,
    mockServices: [
      ParameterizedTransient<Transient66, int>((p) {
        final mockTransient66 = MockTransient66();

        when(mockTransient66.value).thenReturn(100500);

        return mockTransient66;
      }),
    ],
  );

  RootInjectorForTest(newServices);
  test('Scoped62', () {
    final Scoped62 scoped62 = Scoped62(777);

    expect(scoped62.value, 100500);
  });
}
