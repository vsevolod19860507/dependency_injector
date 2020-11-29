import 'package:dependency_injector/dependency_injector.dart';

import 'base_service.dart';

abstract class BaseParameters extends BaseService {
  static int counter = 0;

  BaseParameters() : super(counter++);

  void dispose() {
    counter = 3;
  }
}

class Singleton41 extends BaseParameters {
  Singleton41(this.value);

  final String value;

  final Singleton42 singleton42 = inject(parameters: '111');
  final Transient42 transient42 = inject(parameters: '111');
}

class Scoped41 extends BaseParameters {
  Scoped41(this.value);

  final String value;

  final Singleton42 singleton42 = inject(parameters: '111');
  final Scoped42 scoped42 = inject(parameters: '111');
  final Transient42 transient42 = inject(parameters: '111');
}

class Transient41 extends BaseParameters {
  Transient41(this.value);

  final String value;

  final Singleton42 singleton42 = inject(parameters: '111');
  final Scoped42 scoped42 = inject(parameters: '111');
  final Transient42 transient42 = inject(parameters: '111');
}

class ParametersForTransient41 {
  ParametersForTransient41(this.value);

  final String value;
}

class Singleton42 extends BaseParameters {
  Singleton42(this.value);

  final String value;
}

class Scoped42 extends BaseParameters {
  Scoped42(this.value);

  final String value;
}

class Transient42 extends BaseParameters {
  Transient42(this.value);

  final String value;
}

class Transient43 extends BaseParameters {
  Transient43(this.value);

  final String value;
}
