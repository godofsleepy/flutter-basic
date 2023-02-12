import 'package:flutter/material.dart';

class ListHewan extends StatefulWidget {
  const ListHewan({super.key});

  @override
  State<ListHewan> createState() => _ListHewanState();
}

class _ListHewanState extends State<ListHewan> {
  var dropdownValue = "One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            child: Text('TextButton'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('ElevatedButton'),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text('OutlineButton'),
          )
        ],
      ),
    );
  }
}
