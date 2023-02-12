import 'package:flutter/material.dart';
import 'package:learnflu/main.dart';
import 'package:learnflu/todolist/home_screen.dart';
import 'package:learnflu/todolist/local/local_data.dart';
import 'package:learnflu/todolist/model/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Key
  final formKey = GlobalKey<FormState>();

  bool isObsecure = true;
  List<String> list = <String>['Pemadam', 'Polisi', 'Menteri', 'TNI'];

  // Controller input
  String? pekerjaanValue;
  TextEditingController namaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Map<String, dynamic> resultForm = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: const Text("Register"),
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
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: "Nama",
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
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
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
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: isObsecure,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hoverColor: primary,
                    isDense: true,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (isObsecure) {
                          setState(() {
                            isObsecure = false;
                          });
                        } else {
                          setState(() {
                            isObsecure = true;
                          });
                        }
                      },
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silahkan field ini diisi";
                    }
                    if (value.isNotEmpty && value.length < 8) {
                      return "Password minimal 8 karakter";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                DropdownButtonFormField(
                  value: pekerjaanValue,
                  hint: Text("Pekerjaan"),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hoverColor: primary,
                    isDense: true,
                    border: const OutlineInputBorder(),
                  ),
                  isExpanded: true,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      pekerjaanValue = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Silahkan field ini diisi";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    onPressed: () async {
                      // With form
                      try {
                        if (formKey.currentState!.validate()) {
                          final user = UserModel(
                            name: namaController.text,
                            username: usernameController.text,
                            password: passwordController.text,
                            pekerjaan: pekerjaanValue,
                          );

                          await LocalData.saveUser(user);
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (route) => false,
                            );
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

                      // Manual
                      // if (namaController.text.isEmpty) {
                      //   print("nama tidak valid");
                      // }
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
