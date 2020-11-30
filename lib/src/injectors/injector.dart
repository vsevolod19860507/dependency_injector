part of '../dependency_injector.dart';

/// Used as a wrapper for the widget you want to inject dependencies into.
class Injector extends StatefulWidget {
  const Injector(
    this.builder, {
    Key key,
  })  : assert(builder != null),
        super(key: key);

  final Widget Function() builder;

  @override
  _InjectorState createState() => _InjectorState();
}

class _InjectorState extends State<Injector> with _Injector {
  _RootInjectorState _rootInjectorState;

  @override
  Set<_Service<Object, Object>> get _services => _rootInjectorState._services;

  @override
  Set<_BuiltService<Object>> get _singletonServices =>
      _rootInjectorState._singletonServices;

  Set<_BuiltService<Object>> _builtServices = {};

  T _getInstance<T, P>({
    ServiceKeyBase key,
    ServiceIndex index = ServiceIndex.zero,
    P parameters,
  }) {
    _Injector._checkInjectAvailability();

    final service = _getService<T>(key);

    if (service is _Singleton<T, P>) {
      _Injector._inject = _rootInjectorState._getInstance;

      final instance =
          service._getInstance(_rootInjectorState, index, parameters) as T;

      _Injector._inject = _getInstance;

      return instance;
    }

    return service._getInstance(this, index, parameters) as T;
  }

  T _getBuiltInstance<T, P>({
    ServiceKeyBase key,
    ServiceIndex index = ServiceIndex.zero,
    P parameters,
  }) {
    _Injector._checkInjectAvailability();

    final service = _builtServices._getServiceOrNull(_ServiceId<T>(key), index);

    if (service == null) {
      throw InjectorError(
        title: 'New service not found!',
        message:
            'You are injecting a new service ${_ServiceId<T>(key)._name}#$index after the injector has been initialized.',
        todo:
            'If you just added a new dependency manually during development, just do a hot restart.\nIf not, make sure you are not adding new dependencies as a result of conditional statements or expressions, or something like this, after the injector has been initialized.',
      );
    }

    return service._instance as T;
  }

  @override
  void initState() {
    super.initState();

    _rootInjectorState =
        context._getInheritedWidget<_InheritedRootInjector>()?._state;

    if (_rootInjectorState == null) {
      throw InjectorError(
        title: 'RootInjector not found!',
        message: 'You must have one RootInjector at the root of your tree.',
        todo: 'Add a RootInjector to the root of your tree.',
      );
    }

    _scopedServices.addAll(
        context._getInheritedWidget<_InheritedInjector>()?._scopedServices ??
            {});

    _Injector._inject = _getInstance;

    widget.builder();

    _Injector._inject = _Injector._injectError;

    _builtServices = {
      ..._singletonServices,
      ..._scopedServices,
      ..._localServices,
    };
  }

  @override
  void dispose() {
    for (final service in _localServices) {
      service._dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _Injector._inject = _getBuiltInstance;

    final child = widget.builder();

    _Injector._inject = _Injector._injectError;

    return _InheritedInjector(
      scopedServices: _scopedServices,
      child: child,
    );
  }
}

class _InheritedInjector extends InheritedWidget {
  const _InheritedInjector({
    Key key,
    @required Set<_BuiltService<Object>> scopedServices,
    @required Widget child,
  })  : _scopedServices = scopedServices,
        super(key: key, child: child);

  final Set<_BuiltService<Object>> _scopedServices;

  @override
  bool updateShouldNotify(_InheritedInjector oldWidget) => false;
}
