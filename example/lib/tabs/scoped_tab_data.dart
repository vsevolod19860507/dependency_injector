import 'package:dependency_injector/dependency_injector.dart';

import 'base_service.dart';

abstract class BaseScoped extends BaseService {
  static int counter = 0;

  BaseScoped() : super(counter++);

  void dispose() {
    counter = 0;
  }
}

class Singleton21 {}

class Scoped21 extends BaseScoped {
  final Singleton21 singleton21 = inject();
  final Scoped22 scoped22 = inject();
  final Transient21 transient21 = inject();
  final Scoped23 scoped23 = inject();
}

class Transient21 {
  final Scoped23 scoped23 = inject();
}

class Scoped22 extends BaseScoped {
  final Scoped23 scoped23 = inject();
}

class Transient22 {
  final Scoped23 scoped23 = inject();
}

class Scoped23 extends BaseScoped {}
