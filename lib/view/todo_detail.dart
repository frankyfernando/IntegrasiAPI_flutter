import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoDetailScreen extends StatelessWidget {
  String todoName;
  bool todoStatus;
  TodoDetailScreen(
      {super.key, required this.todoName, required this.todoStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(todoName),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title : $todoName',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Status : $todoStatus",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
