import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnflu/main.dart';
import 'package:learnflu/todolist/add_screen.dart';
import 'package:learnflu/todolist/local/local_data.dart';
import 'package:learnflu/todolist/login_screen.dart';
import 'package:learnflu/todolist/model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  final DateFormat time = DateFormat("HH.mm");
  final DateFormat date = DateFormat("dd MMM yyyy HH.mm");

  List<TodoModel> data = [];

  void getData(DateTime date) async {
    final resultLocal = await LocalData.getTodos();

    setState(() {
      data = resultLocal.where((element) {
        if (element.date == null) return false;

        final elementDate = element.date!;
        final differrence = elementDate.difference(date);
        return differrence.inDays == 0 && elementDate.day == date.day;
      }).toList();
      data.sort((a, b) => a.date!.compareTo(b.date!));
    });
  }

  @override
  void initState() {
    super.initState();
    getData(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              foregroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1670272501500-1cb2a4155076?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
                scale: 8,
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primary),
              child: const Text(
                "Todo List App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await LocalData.logout();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              title: Text("Logout"),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "To-Do list",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final value = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2023, 1, 1),
                        lastDate: DateTime.now().add(
                          Duration(
                            days: 356,
                          ),
                        ),
                      );
                      if (value != null) {
                        setState(() {
                          selectedDate = value;
                          getData(value);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            selectedDate.day.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            DateFormat("MMM").format(selectedDate),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      14,
                    ),
                  ),
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Detail Task",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      initialValue: data[index].title,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hoverColor: primary,
                                        isDense: true,
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      initialValue: data[index].description,
                                      maxLines: 4,
                                      readOnly: true,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hoverColor: primary,
                                        isDense: true,
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      initialValue: date
                                          .format(data[index].date as DateTime),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                        ),
                                        hoverColor: primary,
                                        isDense: true,
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                    if (data[index].status != true)
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primary,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  data[index] =
                                                      data[index].copyWith(
                                                    status: true,
                                                  );
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text("Selesai"),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        title: Text(
                          data[index].title ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          data[index].description ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: primary,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              time.format(data[index].date as DateTime),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primary,
                              ),
                            ),
                            if (data[index].status == true)
                              Row(
                                children: const [
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 28,
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.push<bool?>(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
          if (value != null) {
            getData(selectedDate);
          }
        },
        child: Icon(
          Icons.add,
          size: 28,
        ),
        backgroundColor: primary,
      ),
    );
  }
}
