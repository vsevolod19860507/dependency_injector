part of '../dependency_injector.dart';

/// Injector error.
@immutable
class InjectorError extends Error {
  InjectorError({
    @required this.title,
    @required this.message,
    @required this.todo,
  });

  final String title;
  final String message;
  final String todo;

  @override
  String toString() => '$title\n\n$message\n\n$todo';
}

extension _BuildContextExtension on BuildContext {
  T _getInheritedWidget<T extends InheritedWidget>() =>
      getElementForInheritedWidgetOfExactType<T>()?.widget as T;
}

/// Typedef for inject property.
typedef Inject = T Function<T, P extends Object>({
  ServiceKeyBase key,
  ServiceIndex index,
  P parameters,
});

/// Property used for dependency injection.
Inject get inject => _Injector._inject;

mixin _Injector {
  @alwaysThrows
  static T _injectError<T, P>({
    ServiceKeyBase key,
    ServiceIndex index,
    P parameters,
  }) {
    throw InjectorError(
      title: 'Incorrect use of the inject property!',
      message:
          'You must use inject properties while the builder method is running.',
      todo: 'Check where you are using inject properties.',
    );
  }

  static Inject _inject = _injectError;

  static void _checkInjectAvailability() {
    if (_inject == _injectError) {
      _injectError<void, Object>();
    }
  }

  Set<_Service<Object, Object>> _services = {};

  final Set<_BuiltService<Object>> _singletonServices = {};
  final Set<_BuiltService<Object>> _scopedServices = {};
  final Set<_BuiltService<Object>> _localServices = {};

  _Service<Object, Object> _getService<T>(ServiceKeyBase key) {
    final service = _services._getServiceOrNull(_ServiceId<T>(key));

    if (service == null) {
      throw InjectorError(
        title: 'Service not found!',
        message: 'The next service not found: ${_ServiceId<T>(key)._name}.',
        todo:
            'If this happened during development, do a hot restart first.\nIf not or did not help then check the service parameter of the RootInjector, add the configuration for the missing service.',
      );
    }

    return service;
  }
}
