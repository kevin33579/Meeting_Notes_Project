import 'package:flutter/material.dart';
import 'package:meeting_notes_project/shared/shared.dart';
import 'package:meeting_notes_project/views/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meeting Notes Project",
      theme: Themes.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        Login.routeName: (context) => Login(),
        MainMenu.routeName: (context) => MainMenu(),
        Register.routeName: (context) => Register(),
      },
    );
  }
}