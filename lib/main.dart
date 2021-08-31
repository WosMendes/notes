import 'package:flutter/material.dart';
import 'package:notes/src/constants/strings_constants.dart';
import 'package:notes/src/providers/note_provider.dart';
import 'package:notes/src/providers/theme_provider.dart';
import 'package:notes/src/screens/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: NotesApp(),
    ),
  );
}

class NotesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: StringsConstants.appName,
      //theme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: HomeView(),
    );
  }
}
