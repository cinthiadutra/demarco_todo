import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CardTodo extends StatefulWidget {
  final String? data;
  final String? id;
  final String? taks;
  final String? user;
    final String? complet;
  final VoidCallback? function;
  final VoidCallback? function2;
  const CardTodo(
      {super.key,
      this.data,
      this.taks,
      this.function,
      this.function2,
      this.user,
      this.id, this.complet});

  @override
  State<CardTodo> createState() => _cardTodoState();
}

class _cardTodoState extends State<CardTodo> {
  final ref = FirebaseDatabase.instance.ref('Post');
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.data ?? '',
              style: const TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${widget.taks} ',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              'Usuario :${widget.user}',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'id :${widget.id}',
              style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.transparent),
            ),
            Text(
              'Status :${widget.complet}',
              style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.transparent),
            ),
          ]),
        ],
      ),
    );
  }
}
