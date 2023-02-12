import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:learnflu/todolist/model/todo_model.dart';
import 'package:learnflu/todolist/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keyUser = "users";
const keyIsLogin = "islogin";
const keyTodo = "todo";

class LocalData {
  static Future<bool> checkIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(keyIsLogin);

    return value ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLogin, false);
  }

  static Future<void> saveUser(UserModel user) async {
    // Sebuah lemari yang berisi laci-laci
    final prefs = await SharedPreferences.getInstance();
    // Sebuah laci bernama user didalam lemari
    final value = prefs.getString(keyUser);

    // Mengecek apakah ada lacinya atau tidak
    if (value != null) {
      // Ini adalah lacinya
      final localData = jsonDecode(value) as List<dynamic>;
      // Simpan user ke dalam laci
      localData.add(user.toMap());
      // Lalu simpan laci kedalam lemari
      await prefs.setString(keyUser, jsonEncode(localData));
    } else {
      // Jika tidak ada laci maka membuat laci sekaligus dengan usernya
      final saveData = jsonEncode([user.toMap()]);
      // Simpan ke dalam lemari
      await prefs.setString(keyUser, saveData);
    }
    await prefs.setBool(keyIsLogin, true);
  }

  static Future<void> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(keyUser);
    if (value != null) {
      final localData = (jsonDecode(value) as List<dynamic>)
          .map((e) => UserModel.fromMap(e))
          .toList();
      final valueUser = localData.firstWhereOrNull(
        (element) => element.username == username,
      );
      if (valueUser == null) {
        throw Exception("Username tidak ditemukan");
      }
      if (valueUser.password != password) {
        throw Exception("Password anda salah");
      }
      await prefs.setBool(keyIsLogin, true);
      return;
    } else {
      throw Exception("Username tidak ditemukan");
    }
  }

  static Future<void> saveTodo(TodoModel todo) async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(keyTodo);

    // Mengecek apakah ada lacinya atau tidak
    if (value != null) {
      // Ini adalah lacinya
      final localData = jsonDecode(value) as List<dynamic>;
      // Simpan user ke dalam laci
      localData.add(todo.toMap());
      // Lalu simpan laci kedalam lemari
      await prefs.setString(keyTodo, jsonEncode(localData));
    } else {
      // Jika tidak ada laci maka membuat laci sekaligus dengan usernya
      final saveData = jsonEncode([todo.toMap()]);
      // Simpan ke dalam lemari
      await prefs.setString(keyTodo, saveData);
    }
  }

  static Future<List<TodoModel>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(keyTodo);
    if (value != null) {
      final localData = (jsonDecode(value) as List<dynamic>)
          .map((e) => TodoModel.fromMap(e))
          .toList();
      return localData;
    } else {
      return [];
    }
  }
}
