import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoController extends ChangeNotifier {
  TodoController() {
    fetchData();
  }
  List<dynamic> _todos = [];
  List<dynamic> get todos => _todos;
  bool isLoading = false;
  set changeTodos(List<dynamic> value) {
    _todos = value;
    notifyListeners();
  }

  List<dynamic> _users = [];
  List<dynamic> get users => _users;
  set changeUser(List<dynamic> value) {
    _users = value;
    notifyListeners();
  }

  List<String> userTodo = [];

  fetchData() async {
    try {
      isLoading = true;
      notifyListeners();

      final responseTodo =
          await Future.delayed(const Duration(seconds: 2), () async {
        return await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      });

      final responseUser =
          await Future.delayed(const Duration(seconds: 2), () async {
        return await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      });

      if (responseTodo.statusCode == 200 && responseUser.statusCode == 200) {
        _todos = json.decode(responseTodo.body);
        _users = json.decode(responseUser.body);
        for (int i = 0; i < _todos.length; i++) {
          for (int j = 0; j < _users.length; j++) {
            if (_todos[i]['userId'] == _users[j]['id']) {
              userTodo.add(users[j]['name']);
            }
          }
        }
      } else {
        throw Exception('Failed to Fetch Data');
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
