import 'package:dependency_injector/dependency_injector.dart';

import 'keys.dart';
import 'tabs/dispose_tab_data.dart';
import 'tabs/parameters_tab_data.dart';
import 'tabs/scoped_tab_data.dart';
import 'tabs/singleton_tab_data.dart';
import 'tabs/transient_tab_data.dart';
import 'tabs/variants_tab_data.dart';

final services = [
  // Singleton tab
  Singleton(() => Singleton11()),
  Transient(() => Transient11()),
  Singleton(() => Singleton12()),
  Transient(() => Transient12()),
  Singleton(() => Singleton13()),
  Singleton(() => Singleton13(), key: ServiceKey.key11),

  // Scoped tab
  Singleton(() => Singleton21()),
  Scoped(() => Scoped21()),
  Transient(() => Transient21()),
  Scoped(() => Scoped22()),
  Transient(() => Transient22()),
  Scoped(() => Scoped23()),
  Scoped(() => Scoped23(), key: ServiceKey.key21),

  // Transient tab
  Singleton(() => Singleton31()),
  Scoped(() => Scoped31()),
  Transient(() => Transient31()),
  Singleton(() => Singleton32()),
  Scoped(() => Scoped32()),
  Transient(() => Transient32()),
  Transient(() => Transient33()),
  Transient(() => Transient33(), key: ServiceKey.key31),

  // Parameters Tab
  ParameterizedSingleton<Singleton41, String>(
    (p) => Singleton41(p),
  ),
  ParameterizedScoped<Scoped41, Map<String, Object>>(
    (p) => Scoped41(p['value'] as String),
  ),
  ParameterizedTransient<Transient41, ParametersForTransient41>(
    (p) => Transient41(p.value),
  ),
  ParameterizedSingleton<Singleton42, String>(
    (p) => Singleton42(p),
  ),
  ParameterizedScoped<Scoped42, String>(
    (p) => Scoped42(p),
  ),
  ParameterizedTransient<Transient42, String>(
    (p) => Transient42(p),
  ),
  ParameterizedTransient<Transient43, String>(
    (p) => Transient43(p),
  ),
  ParameterizedTransient<Transient43, String>(
    (p) => Transient43(p),
    key: ServiceKey.key41,
  ),

  // Dispose tab
  Scoped(() => Scoped51()),
  Transient(() => Transient51()),
  ParameterizedScoped<Scoped52, String>(
    (p) => Scoped52(p),
  ),
  ParameterizedTransient<Transient52, String>(
    (p) => Transient52(p),
  ),
  Scoped<Scoped53>(
    () => Scoped53(),
    disposer: (instance) async {
      await Future.delayed(
        Duration.zero,
        () {
          print('*******');
        },
      );
      print(await instance.cancel(instance.name));
      print(await instance.close(instance.name));
      print(await instance.dispose(instance.name));
    },
  ),
  Transient(
    () => Transient53(),
    useDefaultDisposer: false,
  ),

  ParameterizedScoped<Scoped54, String>(
    (p) => Scoped54(p),
    disposer: (instance) async {
      print('*******');
      print(instance.cancel(instance.name));
      print(instance.close(instance.name));
      print(instance.dispose(instance.name));
    },
  ),
  ParameterizedTransient<Transient54, String>(
    (p) => Transient54(p),
  ),

  // Variants tab
  Transient(() => Transient61(transient623: inject(), transient633: inject())),
  ParameterizedScoped<Scoped62, int>(
    (p) => Scoped62(p),
  ),
  Transient(() => Transient62()),
  Transient(() => Transient63()),
  Scoped(() => Scoped61()),
  ParameterizedTransient<Transient64, int>(
    (p) => Transient64(p),
  ),
  ParameterizedTransient<Transient65, int>(
    (p) => Transient65(p),
  ),
  ParameterizedTransient<Transient66, int>(
    (p) => Transient66(p),
  ),
];
