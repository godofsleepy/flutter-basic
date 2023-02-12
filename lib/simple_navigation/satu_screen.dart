import 'package:flutter/material.dart';
import 'package:learnflu/simple_navigation/dua_screen.dart';

class SatuScreen extends StatefulWidget {
  const SatuScreen({super.key});

  @override
  State<SatuScreen> createState() => _SatuScreenState();
}

class _SatuScreenState extends State<SatuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satu"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DuaScreen(),
                  ),
                );
              },
              child: Text(" screen baru megantikan tumpukan"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DuaScreen(),
                  ),
                );
              },
              child: Text("Pindah -> 2"),
            ),
          ],
        ),
      ),
    );
  }
}
