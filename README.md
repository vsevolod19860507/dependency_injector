# Dependency Injector

A dependency injection system for Flutter that automatically calls cancel, close and dispose methods, if any.

See [example](https://github.com/vr19860507/dependency_injector/tree/main/example) for details, and run it!

- [Services](#services)
  - [Singleton](#singleton)
  - [Scoped](#scoped)
  - [Transient](#transient)
  - [Parameters](#parameters)
  - [Dispose](#dispose)
  - [Keys](#keys)
- [Injectors](#injectors)
  - [RootInjector](#rootInjector)
  - [Injector](#injector)
  - [Inject](#inject)
- [Testing](#testing)

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

## Services

There are three types of services: `Singleton`, `Scoped`, `Transient`. They all use lazy initialization.

### Singleton

They are created only once on the first injection and exist as long as the ancestor `RootInjector` exists. Singleton services can contain other singleton or transient services, but they must not contain any scoped services as descendants. Singleton services never call cancel, close and dispose methods.

```dart
Singleton(() => SomeService()),
```

### Scoped

Scoped services are created once for the their parent `Injector` and exist as long as this injector exists, when they are injected again to descendants down the tree, the already created instance is taken. They can contain any other types of services as descendants. Scoped services call cancel, close and dispose methods when their parent `Injector` (for which they were created) is removed from the tree.

```dart
Scoped(() => SomeService()),
```

### Transient

When transient services are used directly in the tree or as descendants of other transient services that are used directly in the tree, they are created once for their parent `Injector` and exist as long as this injector exists, when they are injected again into other injectors that are descendants down the tree, a new instance will be created.
If they are descendants of singleton or scoped services, then their life cycle is the same as for singleton or scoped services. Transient services call cancel, close and dispose methods when their parent `Injector` (for which they were created) is removed from the tree, or according to the life cycle of of singleton or scoped services if they are descendants of them.

```dart
Transient(() => SomeService()),
```

### Parameters

All three types of services have parameterized versions `ParameterizedSingleton`, `ParameterizedScoped`, `ParameterizedTransient`, their life cycle is the same as the regular versions. For example, if you have injected the same `ParameterizedTransient` twice into the same `Injector`, then the second injection will take an existing instance.

```dart
ParameterizedTransient<SomeService, String>(
  (p) => SomeService(p),
),
```

### Dispose

Scoped and Transient (only if Transient services are not descendants of singletons) services, by default, call cancel, close and dispose methods when their life circle ends. They call these methods only if these methods do not have any parameters. If you need to call them with parameters, you have to provide custom disposer, it will override the default disposer.

```dart
Scoped<SomeService>(
  () => SomeService(),
  disposer: (instance) async {
    instance.dispose('some data');
  },
),
```

If you just want to disable a default disposer, set `useDefaultDisposer` to false.

```dart
Transient(
  () => SomeService(),
  useDefaultDisposer: false,
),
```

### Keys

When configuring services, you cannot use the same type more than once.

```dart
final services = [
  Transient(() => 1),
  Singleton(() => 2), // There will be an error.
];
```

In these cases you have to use a key!

```dart
class ServiceKey extends ServiceKeyBase {
  const ServiceKey._(String name) : super(name);

  static const someKey = ServiceKey._('someKey');
}

final services = [
  Transient(() => 1),
  Singleton(() => 2, key: ServiceKey.someKey), // Ok.
];
```

And then another service of this type will be configured.

## Injectors

There are two types of injectors: `RootInjector` and `Injector`, and `inject` property.

### RootInjector

Used to configure services. It should only be used once at the root of your application.

```dart
void main() {
  runApp(RootInjector(
    services: services,
    child: MyApp(),
  ));
}
```

### Injector

Used as a wrapper for the widget into which you will inject dependencies. You should consider the Injector and it's widget as a whole.

```dart
Injector(() => SomeWidget())
```

Never put any logic like conditional statements or expressions inside an injector's builder method. In some cases, this can be the cause of the error, because the injector creates all the instances that you inject only once!

```dart
Injector(() => value == 7 ? SomeWidget1() : SomeWidget2()) // Bad.
```

If you need do this use this pattern.

```dart
value == 7 ? Injector(() => SomeWidget1()) : Injector(() => SomeWidget2()) // Good.
```

Or with keys.

```dart
value == 7 
  ? Injector(() => SomeWidget2(), key: ValueKey(1))
  : Injector(() => SomeWidget2(), key: ValueKey(2)) // Good.
```

### Inject

This is the property you use for dependency injection. It available only while builder method works.

For widgets:

```dart
class SomeWidget extends StatelessWidget {
  SomeWidget({Key key}) : super(key: key);

  final SomeService someService = inject();

  ...
}

...

Injector(() => SomeWidget())
```

```dart
class SomeWidget extends StatelessWidget {
  const SomeWidget(this.someService, {Key key}) : super(key: key);

  final SomeService someService;

  ...
}

...

Injector(() => SomeWidget(inject()))
```

For services:

```dart
class SomeService1 {
  final SomeService2 someService2 = inject();
}

final services = [
  Singleton(() => SomeService1()),
];
```

```dart
class SomeService1 {
  SomeService1(this.someService2);

  final SomeService2 someService2;
}

final services = [
  Singleton(() => SomeService1(inject())),
];
```

When you need inject a service with a key.

```dart
class SomeService1 {
  final SomeService2 someService21 = inject();
  final SomeService2 someService22 = inject(key: ServiceKey.someKey);
}
```

When you need inject a service with parameters.

```dart
class SomeService1 {
  final SomeService2 someService2 = inject(parameters: 'Some parameter');
}
```

If you want to get another one instance of the same service, you can use `ServiceIndex`. All services have a zero index by default.

```dart
class SomeService1 {
  final SomeService2 someService21 = inject(parameters: 1); // someService21.value == 1
  final SomeService2 someService22 = inject(parameters: 2); // someService22.value == 1
  final SomeService2 someService23 = inject(
    parameters: 3,
    index: ServiceIndex.zero,
  ); // someService23.value == 1
  final SomeService2 someService24 = inject(
    parameters: 4,
    index: ServiceIndex.one,
  ); // someService24.value == 4
}
```

## Testing

For unit tests you should use `RootInjectorForTest` to make `inject` property available.

```dart
void main() {
  RootInjectorForTest(services);
  test('Some Unit Test', () {
    final SomeService someService = inject();

    ...

  });
```

For widget tests do this

```dart
void main() {
  testWidgets('Some Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      RootInjector(
        services: services,
        child: MaterialApp(
          home: Scaffold(
            body: Injector(() => SomeWidget()),
          ),
        ),
      ),
    );

    ...

  });
}
```

If you need to replace a service with mock you may use `replaceWithMock` method.

```dart

class MockSomeService extends Mock implements SomeService {}

void main() {
  final newServices = replaceWithMock(
    services: services,
    mockServices: [
      ParameterizedScoped<SomeService, int>((p) {
        final mockSomeService = MockSomeService();

        when(mockSomeService.value).thenReturn(100500);

        return mockSomeService;
      }),
    ],
  );

  ...

}
```








