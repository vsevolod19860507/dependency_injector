part of 'dependency_injector.dart';

@visibleForTesting
class RootInjectorForTest with _Injector {
  RootInjectorForTest(List<Service> services)
      : assert(services != null),
        assert(services.every((s) => s != null)) {
    _services = _RootInjectorState._getSetOfServices(services);

    _Injector._inject = _getInstance;
  }

  T _getInstance<T, P>({
    ServiceKeyBase key,
    ServiceIndex index = ServiceIndex.zero,
    P parameters,
  }) {
    final service = _getService<T>(key);

    return service._getInstance(this, index, parameters) as T;
  }
}

@visibleForTesting
List<Service> replaceWithMock({
  @required List<Service> services,
  @required List<Service> mockServices,
}) =>
    {...mockServices, ...services}.toList();
