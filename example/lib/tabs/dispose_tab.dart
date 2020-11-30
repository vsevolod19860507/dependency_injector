import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import 'app_card.dart';
import 'dispose_tab_data.dart';

class DisposeTab extends StatelessWidget {
  const DisposeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Injector(() => Scope1(name: 'Injector 1:')),
      ],
    );
  }
}

class Scope1 extends StatelessWidget {
  Scope1({Key key, @required this.name}) : super(key: key);

  final Scoped51 scoped51 = inject();
  final Scoped53 scoped53 = inject();
  final Transient53 transient53 = inject();
  final Scoped54 scoped54 = inject(parameters: '111');
  final Transient54 transient54 = inject(parameters: '222');

  final String name;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          scoped51.toText(0),
          scoped51.transient51.toText(10),
          scoped51.transient51.scoped52.toText(
            20,
            suffix: '.value = \'${scoped51.transient51.scoped52.value}\'',
          ),
          scoped51.transient51.scoped52.transient52.toText(
            30,
            suffix:
                '.value = \'${scoped51.transient51.scoped52.transient52.value}\'',
          ),
          scoped53.toText(0),
          transient53.toText(0),
          scoped54.toText(
            0,
            suffix: '.value = \'${scoped54.value}\'',
          ),
          transient54.toText(
            0,
            suffix: '.value = \'${transient54.value}\'',
          ),
        ],
      ),
    );
  }
}
