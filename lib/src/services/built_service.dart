part of '../dependency_injector.dart';

class _BuiltService<T> extends Service {
  _BuiltService({
    @required _ServiceIdBase id,
    @required ServiceIndex index,
    @required T instance,
    @required Disposer<T> disposer,
  })  : _instance = instance,
        _dispose = (() async => disposer(instance)),
        super._(id, index);

  final T _instance;

  final Future<void> Function() _dispose;
}
