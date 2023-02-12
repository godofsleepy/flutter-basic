import 'package:flutter/material.dart';
import 'package:learnflu/hewan/home_hewan.dart';
import 'package:learnflu/laern_set_state/learn_set_state.dart';
import 'package:learnflu/simple_navigation/satu_screen.dart';
import 'package:learnflu/todolist/login_screen.dart';
import 'package:learnflu/todolist/register_screen.dart';
import 'package:learnflu/todolist/splash_screen.dart';

final Color primary = Color(0xff004C96);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
