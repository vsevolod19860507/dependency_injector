part of '../dependency_injector.dart';

mixin _Singleton<T, P> on _Service<T, P> {
  @override
  Object _getInstance(_Injector injector, ServiceIndex index, P parameters) {
    final service = injector._singletonServices._getServiceOrNull(_id, index);

    if (service != null) {
      return service._instance;
    }

    final newService = _buildService(index, parameters);

    injector._singletonServices.add(newService);

    return newService._instance;
  }
}

class Singleton<T> extends _Service<T, Object>
    with _ServiceMixin<T, Object>, _Singleton<T, Object> {
  Singleton(
    Builder<T> builder, {
    ServiceKeyBase key,
  })  : assert(builder != null),
        super(
          builder: builder,
          key: key,
          useDefaultDisposer: false,
        );
}

class ParameterizedSingleton<T, P> extends _Service<T, P>
    with _ParameterizedServiceMixin<T, P>, _Singleton<T, P> {
  ParameterizedSingleton(
    ParameterizedBuilder<T, P> builder, {
    ServiceKeyBase key,
  })  : assert(builder != null),
        super(
          parameterizedBuilder: builder,
          key: key,
          useDefaultDisposer: false,
        );
}
