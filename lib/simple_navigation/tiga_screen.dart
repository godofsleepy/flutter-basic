import 'package:flutter/material.dart';

class TigaScreen extends StatefulWidget {
  const TigaScreen({super.key});

  @override
  State<TigaScreen> createState() => _TigaScreenState();
}

class _TigaScreenState extends State<TigaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiga"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: Text("Pindah -> 1"),
        ),
      ),
    );
  }
}
