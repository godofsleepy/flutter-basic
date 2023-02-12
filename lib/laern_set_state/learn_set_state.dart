import 'package:flutter/material.dart';
import 'package:learnflu/whatsapp/data.dart';

class LearnSetState extends StatefulWidget {
  const LearnSetState({super.key});

  @override
  State<LearnSetState> createState() => _LearnSetStateState();
}

class _LearnSetStateState extends State<LearnSetState> {
  List<Map<String, dynamic>> data = [
    {
      "title": "a",
      "status": false,
    },
    {
      "title": "b",
      "status": false,
    },
    {
      "title": "c",
      "status": false,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("learn"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]["title"]),
            trailing: data[index]["status"]
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        data[index]["status"] = true;
                      });
                    },
                    child: Text("button"),
                  ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
