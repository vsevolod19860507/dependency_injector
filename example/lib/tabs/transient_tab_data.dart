import 'package:dependency_injector/dependency_injector.dart';

import 'base_service.dart';

abstract class BaseTransient extends BaseService {
  static int counter = 0;

  BaseTransient() : super(counter++);

  void dispose() {
    counter = 1;
  }
}

class Singleton31 {
  final Transient33 transient33 = inject();
}

class Scoped31 {
  final Transient33 transient33 = inject();
}

class Transient31 extends BaseTransient {
  final Singleton31 singleton31 = inject();
  final Scoped31 scoped31 = inject();
  final Transient32 transient32 = inject();
  final Transient33 transient33 = inject();
}

class Singleton32 {
  final Transient33 transient33 = inject();
}

class Scoped32 {
  final Transient33 transient33 = inject();
}

class Transient32 extends BaseTransient {
  final Transient33 transient33 = inject();
}

class Transient33 extends BaseTransient {}
