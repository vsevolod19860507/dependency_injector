import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import 'app_card.dart';
import 'variants_tab_data.dart';

final scope4List = List.generate(
  5,
  (index) => Injector(() => Scope4(
        name: 'Injector ${index + 5}:',
        transient65: inject(parameters: index),
      )),
);

class VariantsTab extends StatelessWidget {
  const VariantsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Injector(() => Scope1(
              name: 'Injector 1:',
              transient613: inject(),
              transient623: inject(),
              transient633: inject(),
            )),
        Injector(() => Scope2(
              name: 'Injector 2:',
            )),
        ListView.builder(
          shrinkWrap: true,
          itemCount: scope4List.length,
          itemBuilder: (context, index) => scope4List[index],
        ),
      ],
    );
  }
}

class Scope1 extends StatelessWidget {
  Scope1({
    Key key,
    @required this.name,
    @required this.transient613,
    @required this.transient623,
    @required this.transient633,
  })  : transient612 = inject(),
        transient622 = inject(),
        transient632 = inject(),
        super(key: key);

  final Transient61 transient611 = inject();
  final Transient61 transient612;
  final Transient61 transient613;
  final Transient62 transient621 = inject();
  final Transient62 transient622;
  final Transient62 transient623;
  final Transient63 transient631 = inject();
  final Transient63 transient632;
  final Transient63 transient633;

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
          transient611.toText(0),
          transient611.transient621.toText(10),
          transient611.transient622.toText(10),
          transient611.transient623.toText(10),
          transient611.transient631.toText(10),
          transient611.transient632.toText(10),
          transient611.transient633.toText(10),
          transient612.toText(0),
          transient613.toText(0),
          transient621.toText(0),
          transient622.toText(0),
          transient623.toText(0),
          transient631.toText(0),
          transient632.toText(0),
          transient633.toText(0),
        ],
      ),
    );
  }
}

class Scope2 extends StatefulWidget {
  Scope2({
    Key key,
    @required this.name,
  }) : super(key: key);

  final Scoped61 scoped61 = inject();

  final String name;

  @override
  _Scope2State createState() => _Scope2State();
}

class _Scope2State extends State<Scope2> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.scoped61.decrement();
                  });
                },
                icon: const Icon(Icons.remove),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.scoped61.increment();
                  });
                },
                icon: const Icon(Icons.add),
                color: Colors.red,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Injector(
                  () => Scope3(
                    name: 'Injector 3:',
                    transient64: inject(parameters: widget.scoped61.value),
                  ),
                  key: ValueKey(widget.scoped61.value),
                ),
              ),
              Expanded(
                child: Injector(() => Scope3(
                      name: 'Injector 4:',
                      transient64: inject(parameters: widget.scoped61.value),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Scope3 extends StatelessWidget {
  Scope3({
    Key key,
    @required this.name,
    @required this.transient64,
  }) : super(key: key);

  final Scoped61 scoped61 = inject();
  final Transient64 transient64;

  final String name;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(transient64.value.toString()),
              Text(transient64.scoped61.value.toString()),
              Text(scoped61.value.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class Scope4 extends StatelessWidget {
  const Scope4({
    Key key,
    @required this.name,
    @required this.transient65,
  }) : super(key: key);

  final Transient65 transient65;

  final String name;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(height: 4, color: Colors.blueGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(transient65.value.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
