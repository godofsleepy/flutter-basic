import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnflu/main.dart';
import 'package:learnflu/todolist/local/local_data.dart';
import 'package:learnflu/todolist/model/todo_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({
    super.key,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // Key
  final formKey = GlobalKey<FormState>();

  // Controller input
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Map<String, dynamic> resultForm = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: const Text("Add Todo"),
          centerTitle: true,
          backgroundColor: primary,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                14,
              ),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hoverColor: primary,
                    isDense: true,
                    labelText: "Title",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silahkan field ini diisi";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: descController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hoverColor: primary,
                    labelText: "Description",
                    isDense: true,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silahkan field ini diisi";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    final valueDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 1, 1),
                      lastDate: DateTime.now().add(
                        Duration(
                          days: 356,
                        ),
                      ),
                    );

                    if (valueDate != null) {
                      final valueTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (valueTime == null) return;

                      final date = DateFormat("dd MMM yyyy").format(valueDate);
                      final time = "${valueTime.hour}.${valueTime.minute}";
                      dateController.text = "$date $time";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Date",
                    prefixIcon: Icon(
                      Icons.date_range,
                    ),
                    hoverColor: primary,
                    isDense: true,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silahkan field ini diisi";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    onPressed: () async {
                      try {
                        if (formKey.currentState!.validate()) {
                          final date = DateFormat("dd MMM yyyy HH.mm")
                              .parse(dateController.text);

                          final value = TodoModel(
                            title: titleController.text,
                            description: descController.text,
                            status: false,
                            date: date,
                          );
                          await LocalData.saveTodo(value);
                          if (mounted) {
                            Navigator.pop(context, true);
                          }
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString(),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
