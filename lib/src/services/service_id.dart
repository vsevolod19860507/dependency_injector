part of '../dependency_injector.dart';

@immutable
abstract class _ServiceIdBase {
  const _ServiceIdBase(this._name);

  final String _name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _ServiceIdBase && _name == other._name;

  @override
  int get hashCode => _name.hashCode;
}

class _ServiceId<T> extends _ServiceIdBase {
  _ServiceId(ServiceKeyBase key) : super('$T#key:${key?.name}');
}
