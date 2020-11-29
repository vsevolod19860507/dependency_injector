import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import '../keys.dart';
import 'transient_tab_data.dart';

class TransientTab extends StatelessWidget {
  const TransientTab({Key key}) : super(key: key);

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

  final Transient31 transient31 = inject();
  final Singleton32 singleton32 = inject();
  final Scoped32 scoped32 = inject();
  final Transient32 transient32 = inject();
  final Transient33 transient33 = inject();

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          transient31.toText(0),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Singleton31:'),
          ),
          transient31.singleton31.transient33.toText(20),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Scoped31:'),
          ),
          transient31.scoped31.transient33.toText(20),
          transient31.transient32.toText(10),
          transient31.transient32.transient33.toText(20),
          transient31.transient33.toText(10),
          const Text('Singleton32:'),
          singleton32.transient33.toText(10),
          const Text('Scoped32:'),
          scoped32.transient33.toText(10),
          transient33.toText(0),
          if (child != null) child,
        ],
      ),
    );
  }
}

class Scope2 extends StatelessWidget {
  Scope2({Key key, @required this.name}) : super(key: key);

  final Transient33 transient33KeyNullIndexZero1 = inject();
  final Transient33 transient33KeyNullIndexZero2 = inject();
  final Transient33 transient33KeyNullIndexOne1 = inject(
    index: ServiceIndex.one,
  );
  final Transient33 transient33KeyNullIndexOne2 = inject(
    index: ServiceIndex.one,
  );
  final Transient33 transient33Key31IndexZero1 = inject(
    key: ServiceKey.key31,
  );
  final Transient33 transient33Key31IndexZero2 = inject(
    key: ServiceKey.key31,
  );
  final Transient33 transient33Key31IndexOne1 = inject(
    key: ServiceKey.key31,
    index: ServiceIndex.one,
  );
  final Transient33 transient33Key31IndexOne2 = inject(
    key: ServiceKey.key31,
    index: ServiceIndex.one,
  );

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          transient33KeyNullIndexZero1.toText(0, suffix: 'KeyNullIndexZero'),
          transient33KeyNullIndexZero2.toText(0, suffix: 'KeyNullIndexZero'),
          transient33KeyNullIndexOne1.toText(0, suffix: 'KeyNullIndexOne'),
          transient33KeyNullIndexOne2.toText(0, suffix: 'KeyNullIndexOne'),
          transient33Key31IndexZero1.toText(0, suffix: 'Key31IndexZero'),
          transient33Key31IndexZero2.toText(0, suffix: 'Key31lIndexZero'),
          transient33Key31IndexOne1.toText(0, suffix: 'Key31IndexOne'),
          transient33Key31IndexOne2.toText(0, suffix: 'Key31IndexOne'),
        ],
      ),
    );
  }
}
