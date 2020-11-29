import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import 'services.dart';
import 'tabs/dispose_tab.dart';
import 'tabs/parameters_tab.dart';
import 'tabs/scoped_tab.dart';
import 'tabs/singleton_tab.dart';
import 'tabs/transient_tab.dart';
import 'tabs/variants_tab.dart';

void main() {
  runApp(RootInjector(
    services: services,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dependency Injector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dependency Injector'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Singleton'),
              Tab(text: 'Scoped'),
              Tab(text: 'Transient'),
              Tab(text: 'Parameters'),
              Tab(text: 'Dispose'),
              Tab(text: 'Variants'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SingletonTab(),
            ScopedTab(),
            TransientTab(),
            ParametersTab(),
            DisposeTab(),
            VariantsTab(),
          ],
        ),
      ),
    );
  }
}
