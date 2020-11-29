import 'package:dependency_injector/dependency_injector.dart';

class ServiceKey extends ServiceKeyBase {
  const ServiceKey._(String name) : super(name);

  // Singleton tab
  static const key11 = ServiceKey._('key11');

  // Scoped tab
  static const key21 = ServiceKey._('key21');

  // Transient tab
  static const key31 = ServiceKey._('key31');

  // Parameters Tab
  static const key41 = ServiceKey._('key41');
}
