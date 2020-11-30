part of '../dependency_injector.dart';

/// Service indexes.
enum ServiceIndex { zero, one, two, three, four, five, six, seven, eight, nine }

/// Base class for keys.
@immutable
abstract class ServiceKeyBase {
  const ServiceKeyBase(this.name);

  final String name;
}

/// Typedef for builder function.
typedef Builder<T> = T Function();

/// Typedef for parameterizedBuilder function.
typedef ParameterizedBuilder<T, P> = T Function(P parameters);

/// Typedef for disposer function.
typedef Disposer<T> = Future<void> Function(T);

extension _SetExtension<T extends Service> on Set<T> {
  T _getServiceOrNull(
    _ServiceIdBase id, [
    ServiceIndex index = ServiceIndex.zero,
  ]) =>
      firstWhere(
        (s) => s._id == id && s._index == index,
        orElse: () => null,
      );
}

/// Base class for all services.
@immutable
abstract class Service {
  const Service._(_ServiceIdBase id, ServiceIndex index)
      : _id = id,
        _index = index;

  final _ServiceIdBase _id;

  final ServiceIndex _index;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Service && _id == other._id && _index == other._index;

  @override
  int get hashCode => _id.hashCode ^ _index.hashCode;
}

abstract class _Service<T, P> extends Service {
  _Service({
    Builder<T> builder,
    ParameterizedBuilder<T, P> parameterizedBuilder,
    ServiceKeyBase key,
    Disposer<T> disposer,
    @required bool useDefaultDisposer,
  })  : _builder = builder,
        _parameterizedBuilder = parameterizedBuilder,
        _disposer = disposer ??
            (useDefaultDisposer ? _defaultDisposer : _emptyDisposer),
        super._(_ServiceId<T>(key), ServiceIndex.zero);

  final Builder<T> _builder;

  final ParameterizedBuilder<T, P> _parameterizedBuilder;

  final Disposer<T> _disposer;

  Object _getInstance(_Injector injector, ServiceIndex index, P parameters);

  _BuiltService<T> _buildService(ServiceIndex index, P parameters) =>
      _BuiltService(
        id: _id,
        index: index,
        instance: _buildInstance(parameters),
        disposer: _disposer,
      );

  T _buildInstance(P parameters);

  static Future<void> _emptyDisposer<T>(T instance) async {}

  static Future<void> _defaultDisposer<T>(T instance) async {
    final dynamic _instance = instance as dynamic;

    try {
      _instance.cancel();
    } on Object catch (_) {}
    try {
      _instance.close();
    } on Object catch (_) {}
    try {
      _instance.dispose();
    } on Object catch (_) {}
  }
}

mixin _ServiceMixin<T, P> on _Service<T, P> {
  @override
  T _buildInstance(P parameters) => _builder();
}

mixin _ParameterizedServiceMixin<T, P> on _Service<T, P> {
  @override
  T _buildInstance(P parameters) => _parameterizedBuilder(parameters);
}
