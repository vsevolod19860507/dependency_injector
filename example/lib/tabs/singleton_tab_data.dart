import 'package:dependency_injector/dependency_injector.dart';

import 'base_service.dart';

abstract class BaseSingleton extends BaseService {
  BaseSingleton() : super(counter++);

  static int counter = 0;
}

class Singleton11 extends BaseSingleton {
  final Singleton12 singleton12 = inject();
  final Transient11 transient11 = inject();
  final Singleton13 singleton13 = inject();
}

class Transient11 {
  final Singleton13 singleton13 = inject();
}

class Singleton12 extends BaseSingleton {
  final Singleton13 singleton13 = inject();
}

class Transient12 {
  final Singleton13 singleton13 = inject();
}

class Singleton13 extends BaseSingleton {}
