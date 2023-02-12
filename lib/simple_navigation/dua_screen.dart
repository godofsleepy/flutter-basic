import 'package:flutter/material.dart';
import 'package:learnflu/simple_navigation/tiga_screen.dart';

class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dua"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TigaScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text("3 Menjadi screen pertama"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TigaScreen(),
                  ),
                );
              },
              child: Text("Pindah -> 3"),
            ),
          ],
        ),
      ),
    );
  }
}
