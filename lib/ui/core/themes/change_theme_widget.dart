import 'package:app_eclipseworkd/ui/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ChangeThemeWidget extends StatefulWidget {
  const ChangeThemeWidget({super.key});

  @override
  State<ChangeThemeWidget> createState() => _ChangeThemeWidgetState();
}

class _ChangeThemeWidgetState extends State<ChangeThemeWidget> {
  final appTheme = AppTheme.instance;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        appTheme.toggleBrightness();
        setState(() {});
      },
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
    );
  }
}
