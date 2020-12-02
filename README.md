# Dependency Injector

A dependency injection system for Flutter that automatically calls cancel, close and dispose methods, if any.

## Getting Started

Configure the services you want to use in your application.

```dart
final services = [
  Transient(() => SomeService()),
  Singleton(() => Repository()),
];
```

Place the `RootInjector` with your services list in the root of your application, and wrap the widget where you want to inject the service in the `Injector`.

```dart
void main() {
  runApp(RootInjector(
    services: services,
    child: Injector(() => MyApp()),
  ));
}
```

Inject your service using the `inject` property.

```dart
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  final SomeService someService = inject();

  ...
}
```

Complete example.

```dart
import 'package:flutter/material.dart';
import 'package:dependency_injector/dependency_injector.dart';

class SomeService {
  final Repository repository = inject();
}

class Repository {
  String getData() => 'Hello world.';
}

final services = [
  Transient(() => SomeService()),
  Singleton(() => Repository()),
];

void main() {
  runApp(RootInjector(
    services: services,
    child: Injector(() => MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  final SomeService someService = inject();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(child: Text(someService.repository.getData())),
      ),
    );
  }
}
```


Documentation coming soon.

For now you can look at the source code of the [example](https://pub.dev/packages/dependency_injector/example) and run it.