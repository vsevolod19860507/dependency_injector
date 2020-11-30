import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import '../keys.dart';
import 'app_card.dart';
import 'scoped_tab_data.dart';

class ScopedTab extends StatelessWidget {
  const ScopedTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: Injector(() => Scope1(
                    name: 'Injector 1:',
                    child: Injector(() => Scope1(name: 'Injector 2:')),
                  )),
            ),
            Expanded(
              child: Injector(() => Scope1(
                    name: 'Injector 3:',
                    child: Injector(() => Scope1(name: 'Injector 4:')),
                  )),
            ),
          ],
        ),
        Injector(() => Scope2(name: 'Injector 5:')),
      ],
    );
  }
}

class Scope1 extends StatelessWidget {
  Scope1({Key key, @required this.name, this.child}) : super(key: key);

  final Scoped21 scoped21 = inject();
  final Scoped22 scoped22 = inject();
  final Transient22 transient22 = inject();
  final Scoped23 scoped23 = inject();

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          scoped21.toText(0),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Singleton21:'),
          ),
          scoped21.scoped22.toText(10),
          scoped21.scoped22.scoped23.toText(20),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Transient21:'),
          ),
          scoped21.transient21.scoped23.toText(20),
          scoped21.scoped23.toText(10),
          scoped22.toText(0),
          scoped22.scoped23.toText(10),
          const Text('Transient22:'),
          transient22.scoped23.toText(10),
          scoped23.toText(0),
          if (child != null) child,
        ],
      ),
    );
  }
}

class Scope2 extends StatelessWidget {
  Scope2({Key key, @required this.name}) : super(key: key);

  final Scoped23 scoped23KeyNullIndexZero1 = inject();
  final Scoped23 scoped23KeyNullIndexZero2 = inject();
  final Scoped23 scoped23KeyNullIndexOne1 = inject(
    index: ServiceIndex.one,
  );
  final Scoped23 scoped23KeyNullIndexOne2 = inject(
    index: ServiceIndex.one,
  );
  final Scoped23 scoped23Key21IndexZero1 = inject(
    key: ServiceKey.key21,
  );
  final Scoped23 scoped23Key21IndexZero2 = inject(
    key: ServiceKey.key21,
  );
  final Scoped23 scoped23Key21IndexOne1 = inject(
    key: ServiceKey.key21,
    index: ServiceIndex.one,
  );
  final Scoped23 scoped23Key21IndexOne2 = inject(
    key: ServiceKey.key21,
    index: ServiceIndex.one,
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
          scoped23KeyNullIndexZero1.toText(0, suffix: 'KeyNullIndexZero'),
          scoped23KeyNullIndexZero2.toText(0, suffix: 'KeyNullIndexZero'),
          scoped23KeyNullIndexOne1.toText(0, suffix: 'KeyNullIndexOne'),
          scoped23KeyNullIndexOne2.toText(0, suffix: 'KeyNullIndexOne'),
          scoped23Key21IndexZero1.toText(0, suffix: 'Key21IndexZero'),
          scoped23Key21IndexZero2.toText(0, suffix: 'Key21lIndexZero'),
          scoped23Key21IndexOne1.toText(0, suffix: 'Key21IndexOne'),
          scoped23Key21IndexOne2.toText(0, suffix: 'Key21IndexOne'),
        ],
      ),
    );
  }
}
