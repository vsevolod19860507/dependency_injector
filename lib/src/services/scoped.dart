part of '../dependency_injector.dart';

mixin _Scoped<T, P> on _Service<T, P> {
  @override
  Object _getInstance(_Injector injector, ServiceIndex index, P parameters) {
    final service = injector._scopedServices._getServiceOrNull(_id, index);

    if (service != null) {
      return service._instance;
    }

    final newService = _buildService(index, parameters);

    injector._scopedServices.add(newService);
    injector._localServices.add(newService);

    return newService._instance;
  }
}

class Scoped<T> extends _Service<T, Object>
    with _ServiceMixin<T, Object>, _Scoped<T, Object> {
  Scoped(
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

class ParameterizedScoped<T, P> extends _Service<T, P>
    with _ParameterizedServiceMixin<T, P>, _Scoped<T, P> {
  ParameterizedScoped(
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
