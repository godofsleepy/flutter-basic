import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learnflu/main.dart';
import 'package:learnflu/todolist/home_screen.dart';
import 'package:learnflu/todolist/local/local_data.dart';
import 'package:learnflu/todolist/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO Ubah ke login
    Future.delayed(Duration(seconds: 1), () async {
      final value = await LocalData.checkIsLogin();
      if (mounted) {
        if (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LoginScreen(),
            ),
          );
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Image.asset("asset/image.png"),
      ),
    );
  }
}
