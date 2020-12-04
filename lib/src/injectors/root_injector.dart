part of '../dependency_injector.dart';

/// Used to configure services. Place it in the root of your application.
class RootInjector extends StatefulWidget {
  RootInjector({
    Key key,
    @required this.services,
    @required this.child,
  })  : assert(services != null),
        assert(services.every((s) => s != null)),
        assert(child != null),
        super(key: key);

  final List<Service> services;

  final Widget child;

  @override
  _RootInjectorState createState() => _RootInjectorState();
}

class _RootInjectorState extends State<RootInjector> with _Injector {
  static Set<_Service<Object, Object>> _getSetOfServices(
      List<Service> services) {
    final _services =
        services.map((s) => s as _Service<Object, Object>).toSet();

    if (services.length != _services.length) {
      final duplicateServices = services.fold<Map<Service, int>>(
        {},
        (acc, s) => acc..update(s, (value) => value + 1, ifAbsent: () => 1),
      )..removeWhere((key, value) => value < 2);

      final message = duplicateServices.entries
          .map((e) => '${e.key._id._name} - ${e.value} times')
          .join('\n\t');

      throw InjectorError(
        title: 'Duplicate services found!',
        message:
            'The following services are described more than once:\n\t$message',
        todo: 'Check the services parameter of the RootInjector, '
            'remove duplicates or provide unique keys for them.',
      );
    }

    return _services;
  }

  @override
  void initState() {
    super.initState();

    if (context._getInheritedWidget<_InheritedRootInjector>() != null) {
      throw InjectorError(
        title: 'Multiple RootInjectors found!',
        message: 'There is more than one RootInjector in the tree.',
        todo: 'Leave only one RootInjector.',
      );
    }

    _services = _getSetOfServices(widget.services);
  }

  T _getInstance<T, P>({
    ServiceKeyBase key,
    ServiceIndex index = ServiceIndex.zero,
    P parameters,
  }) {
    _Injector._checkInjectAvailability();

    final service = _getService<T>(key);

    if (service is _Scoped<T, P>) {
      throw InjectorError(
        title: 'Scoped used inside Singleton!',
        message: 'Singletons cannot have Scoped descendants.',
        todo: 'Remove all Scoped descendants from Singletons.',
      );
    }

    return service._getInstance(this, index, parameters) as T;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedRootInjector(
      state: this,
      child: widget.child,
    );
  }
}

class _InheritedRootInjector extends InheritedWidget {
  const _InheritedRootInjector({
    Key key,
    @required _RootInjectorState state,
    @required Widget child,
  })  : _state = state,
        super(key: key, child: child);

  final _RootInjectorState _state;

  @override
  bool updateShouldNotify(_InheritedRootInjector oldWidget) => false;
}
