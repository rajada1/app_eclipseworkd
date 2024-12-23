import 'package:app_eclipseworkd/ui/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeApp = AppTheme.instance;
    return ListenableBuilder(
        listenable: themeApp,
        builder: (context, child) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: themeApp.resolveBrightness(),
              routerConfig: Modular.routerConfig,
            ));
  }
}
