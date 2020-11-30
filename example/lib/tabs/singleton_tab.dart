import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import '../keys.dart';
import 'app_card.dart';
import 'singleton_tab_data.dart';

class SingletonTab extends StatelessWidget {
  const SingletonTab({Key key}) : super(key: key);

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

  final Singleton11 singleton11 = inject();
  final Singleton12 singleton12 = inject();
  final Transient12 transient12 = inject();
  final Singleton13 singleton13 = inject();

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
          singleton11.toText(0),
          singleton11.singleton12.toText(10),
          singleton11.singleton12.singleton13.toText(20),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Transient11:'),
          ),
          singleton11.transient11.singleton13.toText(20),
          singleton11.singleton13.toText(10),
          singleton12.toText(0),
          singleton12.singleton13.toText(10),
          const Text('Transient12:'),
          transient12.singleton13.toText(10),
          singleton13.toText(0),
          if (child != null) child,
        ],
      ),
    );
  }
}

class Scope2 extends StatelessWidget {
  Scope2({Key key, @required this.name}) : super(key: key);

  final Singleton13 singleton13KeyNullIndexZero1 = inject();
  final Singleton13 singleton13KeyNullIndexZero2 = inject();
  final Singleton13 singleton13KeyNullIndexOne1 = inject(
    index: ServiceIndex.one,
  );
  final Singleton13 singleton13KeyNullIndexOne2 = inject(
    index: ServiceIndex.one,
  );
  final Singleton13 singleton13key11IndexZero1 = inject(
    key: ServiceKey.key11,
  );
  final Singleton13 singleton13key11IndexZero2 = inject(
    key: ServiceKey.key11,
  );
  final Singleton13 singleton13key11IndexOne1 = inject(
    key: ServiceKey.key11,
    index: ServiceIndex.one,
  );
  final Singleton13 singleton13key11IndexOne2 = inject(
    key: ServiceKey.key11,
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
          singleton13KeyNullIndexZero1.toText(0, suffix: 'KeyNullIndexZero'),
          singleton13KeyNullIndexZero2.toText(0, suffix: 'KeyNullIndexZero'),
          singleton13KeyNullIndexOne1.toText(0, suffix: 'KeyNullIndexOne'),
          singleton13KeyNullIndexOne2.toText(0, suffix: 'KeyNullIndexOne'),
          singleton13key11IndexZero1.toText(0, suffix: 'key11IndexZero'),
          singleton13key11IndexZero2.toText(0, suffix: 'key11lIndexZero'),
          singleton13key11IndexOne1.toText(0, suffix: 'key11IndexOne'),
          singleton13key11IndexOne2.toText(0, suffix: 'key11IndexOne'),
        ],
      ),
    );
  }
}
