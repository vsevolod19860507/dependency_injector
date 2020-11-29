import 'package:dependency_injector/dependency_injector.dart';

import 'base_service.dart';

abstract class BaseDispose extends BaseService {
  static int counter = 0;

  BaseDispose() : super(counter++);
}

abstract class BaseDispose1 extends BaseDispose {
  void cancel() {
    print('*******');
    print('$name: ${index + 1} canceled!');
  }

  void close() {
    print('$name: ${index + 1} closed!');
  }

  void dispose() {
    BaseDispose.counter = 0;
    print('$name: ${index + 1} disposed!');
  }
}

class Scoped51 extends BaseDispose1 {
  final Transient51 transient51 = inject();
}

class Transient51 extends BaseDispose1 {
  final Scoped52 scoped52 = inject(parameters: '111');
}

class Scoped52 extends BaseDispose1 {
  Scoped52(this.value);

  final String value;

  final Transient52 transient52 = inject(parameters: '222');
}

class Transient52 extends BaseDispose1 {
  Transient52(this.value);

  final String value;
}

class Scoped53 extends BaseDispose {
  Future<String> cancel(String name) async {
    return '$name: ${index + 1} canceled!';
  }

  Future<String> close(String name) async {
    return '$name: ${index + 1} closed!';
  }

  Future<String> dispose(String name) async {
    return '$name: ${index + 1} disposed!';
  }
}

class Transient53 extends BaseDispose {
  Future<void> cancel() async {
    print('Ignored!');
  }

  Future<void> close() async {
    print('Ignored!');
  }

  Future<void> dispose() async {
    print('Ignored!');
  }
}

class Scoped54 extends BaseDispose {
  Scoped54(this.value);

  final String value;

  String cancel(String name) {
    return '$name: ${index + 1} canceled!';
  }

  String close(String name) {
    return '$name: ${index + 1} closed!';
  }

  String dispose(String name) {
    return '$name: ${index + 1} disposed!';
  }
}

class Transient54 extends BaseDispose {
  Transient54(this.value);

  final String value;

  void cancel() {
    BaseDispose.counter = 0;
    print('*******');
    print('$name: ${index + 1} canceled!');
  }

  void close(String name) {
    print('Ignored!');
  }

  void dispose(String name) {
    print('Ignored!');
  }
}
