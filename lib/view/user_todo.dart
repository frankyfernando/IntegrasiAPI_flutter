import 'package:flutter/material.dart';
import 'package:flutter_latihan/controller/user_todo_controller.dart';
import 'package:flutter_latihan/view/todo_detail.dart';
import 'package:provider/provider.dart';

class USerListTodoScreen extends StatefulWidget {
  const USerListTodoScreen({super.key});

  @override
  State<USerListTodoScreen> createState() => _USerListTodoScreenState();
}

class _USerListTodoScreenState extends State<USerListTodoScreen> {
  @override
  Widget build(BuildContext context) {
    final readListTodoProvider = context.read<TodoController>();
    @override
    // ignore: unused_element
    void initState() {
      super.initState();
      readListTodoProvider.fetchData();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Todo'),
          ),
        ),
        body: Consumer<TodoController>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!provider.isLoading && provider.todos.isEmpty) {
            return AlertDialog(
              title: const Text('Error to Fetch Data'),
              content: const Text('Maaf, di wilayah anda tidak ada internet'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      provider.fetchData();
                    },
                    child: const Text('Try again'))
              ],
            );
          } else {
            return ListView.builder(
                itemCount: readListTodoProvider.todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoDetailScreen(
                            todoName: readListTodoProvider.todos[index]
                                ['title'],
                            todoStatus: readListTodoProvider.todos[index]
                                ['completed'],
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      child: Text(readListTodoProvider.userTodo[index][0]),
                    ),
                    title: Text(provider.todos[index]['title']),
                    trailing: Switch(
                        activeColor: Colors.green,
                        value: provider.todos[index]['completed'],
                        onChanged: (bool value) {
                          setState(() {
                            provider.todos[index]['completed'] = value;
                          });
                        }),
                  );
                });
          }
        }));
  }
}
