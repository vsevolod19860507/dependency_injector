import 'package:dependency_injector/dependency_injector.dart';
import 'package:flutter/material.dart';

import 'base_service.dart';

abstract class BaseVariants extends BaseService {
  static int counter = 0;

  BaseVariants() : super(counter++);

  void dispose() {
    counter = 0;
  }
}

class Transient61 extends BaseVariants {
  Transient61({
    @required this.transient623,
    @required this.transient633,
  })  : transient622 = inject(),
        transient632 = inject();

  final Transient62 transient621 = inject();
  final Transient62 transient622;
  final Transient62 transient623;
  final Transient63 transient631 = inject();
  final Transient63 transient632;
  final Transient63 transient633;
}

class Transient62 extends BaseVariants {}

class Transient63 extends BaseVariants {}

class Scoped61 {
  int value = 0;

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }
}

class Transient64 {
  Transient64(this.value);

  final int value;

  final Scoped61 scoped61 = inject();
}

class Transient65 {
  Transient65(this.value);

  final int value;
}
