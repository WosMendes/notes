import 'package:flutter/material.dart';
import 'package:notes/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      onPressed: () {
        themeProvider.toggleTheme(!themeProvider.isDarkMode);
      },
      icon: themeProvider.isDarkMode
          ? Icon(Icons.light_mode_outlined)
          : Icon(Icons.dark_mode_outlined),
    );
  }
}
