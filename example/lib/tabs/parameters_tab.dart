import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import '../keys.dart';
import 'app_card.dart';
import 'parameters_tab_data.dart';

class ParametersTab extends StatelessWidget {
  const ParametersTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Injector(() => Scope1(name: 'Injector 1:')),
        Injector(() => Scope2(name: 'Injector 2:')),
      ],
    );
  }
}

class Scope1 extends StatelessWidget {
  Scope1({Key key, @required this.name}) : super(key: key);

  final Singleton41 singleton41 = inject(parameters: '222');
  final Scoped41 scoped41 = inject(parameters: {'value': '222'});
  final Transient41 transient41 =
      inject(parameters: ParametersForTransient41('222'));

  final String name;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          singleton41.toText(0, suffix: '.value = \'${singleton41.value}\''),
          singleton41.singleton42.toText(10,
              suffix: '.value = \'${singleton41.singleton42.value}\''),
          singleton41.transient42.toText(10,
              suffix: '.value = \'${singleton41.transient42.value}\''),
          scoped41.toText(0, suffix: '.value = \'${scoped41.value}\''),
          scoped41.singleton42
              .toText(10, suffix: '.value = \'${scoped41.singleton42.value}\''),
          scoped41.scoped42
              .toText(10, suffix: '.value = \'${scoped41.scoped42.value}\''),
          scoped41.transient42
              .toText(10, suffix: '.value = \'${scoped41.transient42.value}\''),
          transient41.toText(0, suffix: '.value = \'${transient41.value}\''),
          transient41.singleton42.toText(10,
              suffix: '.value = \'${transient41.singleton42.value}\''),
          transient41.scoped42
              .toText(10, suffix: '.value = \'${transient41.scoped42.value}\''),
          transient41.transient42.toText(10,
              suffix: '.value = \'${transient41.transient42.value}\''),
        ],
      ),
    );
  }
}

class Scope2 extends StatelessWidget {
  Scope2({Key key, @required this.name}) : super(key: key);

  final Transient43 transient43KeyNullIndexZero1 = inject(
    parameters: '111',
  );
  final Transient43 transient43KeyNullIndexZero2 = inject(
    parameters: '111!!!!!!!',
  );
  final Transient43 transient43KeyNullIndexOne1 = inject(
    index: ServiceIndex.one,
    parameters: '222',
  );
  final Transient43 transient43KeyNullIndexOne2 = inject(
    index: ServiceIndex.one,
    parameters: '222!!!!!!!',
  );
  final Transient43 transient43Key41IndexZero1 = inject(
    key: ServiceKey.key41,
    parameters: '333',
  );
  final Transient43 transient43Key41IndexZero2 = inject(
    key: ServiceKey.key41,
    parameters: '333!!!!!!!',
  );
  final Transient43 transient43Key41IndexOne1 = inject(
    key: ServiceKey.key41,
    index: ServiceIndex.one,
    parameters: '444',
  );
  final Transient43 transient43Key41IndexOne2 = inject(
    key: ServiceKey.key41,
    index: ServiceIndex.one,
    parameters: '444!!!!!!!',
  );

  final String name;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          transient43KeyNullIndexZero1.toText(0,
              suffix:
                  'KeyNullIndexZero.value = \'${transient43KeyNullIndexZero1.value}\''),
          transient43KeyNullIndexZero2.toText(0,
              suffix:
                  'KeyNullIndexZero.value = \'${transient43KeyNullIndexZero2.value}\''),
          transient43KeyNullIndexOne1.toText(0,
              suffix:
                  'KeyNullIndexOne.value = \'${transient43KeyNullIndexOne1.value}\''),
          transient43KeyNullIndexOne2.toText(0,
              suffix:
                  'KeyNullIndexOne.value = \'${transient43KeyNullIndexOne2.value}\''),
          transient43Key41IndexZero1.toText(0,
              suffix:
                  'Key41IndexZero.value = \'${transient43Key41IndexZero1.value}\''),
          transient43Key41IndexZero2.toText(0,
              suffix:
                  'Key41IndexZero.value = \'${transient43Key41IndexZero2.value}\''),
          transient43Key41IndexOne1.toText(0,
              suffix:
                  'Key41IndexOne.value = \'${transient43Key41IndexOne1.value}\''),
          transient43Key41IndexOne2.toText(0,
              suffix:
                  'Key41IndexOne.value = \'${transient43Key41IndexOne2.value}\''),
        ],
      ),
    );
  }
}
