import 'package:dependency_injector/dependency_injector.dart';
import 'package:dependency_injector/dependency_injector_test.dart';
import 'package:example/tabs/parameters_tab_data.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/services.dart';
import 'package:example/tabs/variants_tab_data.dart';

void main() {
  RootInjectorForTest(services);
  test('Scoped62', () {
    final Scoped62 scoped62 = Scoped62(777);

    expect(scoped62.value, 777);

    scoped62.increment();

    expect(scoped62.value, 778);

    scoped62..decrement()..decrement();

    expect(scoped62.value, 776);

    scoped62.reset();

    expect(scoped62.value, 777);
  });

  test('Transient61', () {
    final transient61 = Transient61(
      transient623: inject(),
      transient633: inject(),
    );

    expect(transient61.index, 2);
    expect(transient61.transient622.index, 0);
    expect(transient61.transient633.index, 1);
  });

  test('Scoped41', () {
    final Scoped41 scoped41 = inject(parameters: {'value': '222'});

    expect(scoped41.value, '222');
    expect(scoped41.singleton42.value, '111');
    expect(scoped41.scoped42.value, '111');
    expect(scoped41.transient42.value, '111');
  });
}
