import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject_notes/views/views.dart';

// Run first apps open
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODOS Set orientation always potrait
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //TODOS Set color status bar, light putih, dark hitam
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //TODOS Color bar atas
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: Home(),
    );
  }
}
