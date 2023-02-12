import 'package:flutter/material.dart';
import 'package:learnflu/main.dart';
import 'package:learnflu/todolist/home_screen.dart';
import 'package:learnflu/todolist/local/local_data.dart';
import 'package:learnflu/todolist/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Buat Widget Textfield
// Lalu buat controller diatas function build
// Colokkan atau gabungkan controller dan textfield
// Lalu buat button validasi dan functionnya untuk mengecek controller

class _LoginScreenState extends State<LoginScreen> {
  // State
  bool disableButton = true;
  bool isObsecure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset("asset/image.png"),
              const SizedBox(
                height: 14,
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
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: usernameController,
                        onChanged: (value) {
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            setState(() {
                              disableButton = false;
                            });
                          } else {
                            setState(() {
                              disableButton = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Username",
                          hoverColor: primary,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: isObsecure,
                        onChanged: (value) {
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            setState(() {
                              disableButton = false;
                            });
                          } else {
                            setState(() {
                              disableButton = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          hoverColor: primary,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
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
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primary),
                          onPressed: disableButton
                              ? null
                              : () async {
                                  try {
                                    await LocalData.login(
                                      usernameController.text,
                                      passwordController.text,
                                    );
                                    
                                    if (mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
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
                          child: const Text("Login"),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "New Account ? ",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              " Register",
                              style: TextStyle(color: primary),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
