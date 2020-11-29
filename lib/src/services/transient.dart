part of '../dependency_injector.dart';

mixin _Transient<T, P> on _Service<T, P> {
  @override
  Object _getInstance(_Injector injector, ServiceIndex index, P parameters) {
    final service = injector._localServices._getServiceOrNull(_id, index);

    if (service != null) {
      return service._instance;
    }

    final newService = _buildService(index, parameters);

    injector._localServices.add(newService);

    return newService._instance;
  }
}

class Transient<T> extends _Service<T, Object>
    with _ServiceMixin<T, Object>, _Transient<T, Object> {
  Transient(
    Builder<T> builder, {
    ServiceKeyBase key,
    Disposer<T> disposer,
    bool useDefaultDisposer = true,
  })  : assert(builder != null),
        super(
          builder: builder,
          key: key,
          disposer: disposer,
          useDefaultDisposer: useDefaultDisposer,
        );
}

class ParameterizedTransient<T, P> extends _Service<T, P>
    with _ParameterizedServiceMixin<T, P>, _Transient<T, P> {
  ParameterizedTransient(
    ParameterizedBuilder<T, P> builder, {
    ServiceKeyBase key,
    Disposer<T> disposer,
    bool useDefaultDisposer = true,
  })  : assert(builder != null),
        super(
          parameterizedBuilder: builder,
          key: key,
          disposer: disposer,
          useDefaultDisposer: useDefaultDisposer,
        );
}
