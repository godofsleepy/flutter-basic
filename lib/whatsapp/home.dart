import 'package:flutter/material.dart';
import 'package:learnflu/whatsapp/data.dart';

const Color whatsAppColor = Color(0xff095e54);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whatsAppColor,
          title: const Text("WhatsApp"),
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.photo_camera),
              ),
              Tab(
                text: "CHAT",
              ),
              Tab(
                text: "STATUS",
              ),
              Tab(
                text: "PANGGILAN",
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  data[index].image,
                ),
              ),
              title: Text(
                data[index].namaKontak,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              subtitle: Text(
                data[index].lastMessage,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              trailing: Text(
                data[index].lastTime,
              ),
            );
          },
          itemCount: data.length,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {},
          child: const Icon(
            Icons.comment,
          ),
        ),
      ),
    );
  }
}
