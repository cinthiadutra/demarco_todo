import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CardTodo extends StatefulWidget {
  final String? title;
  final String? id;
  final String? taks;
  final String? user;
  final VoidCallback? function;
  final VoidCallback? function2;
  const CardTodo(
      {super.key,
      this.title,
      this.taks,
      this.function,
      this.function2,
      this.user,
      this.id});

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
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    widget.title ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                      activeColor: Colors.black,
                      checkColor: Colors.black,
                      value: isDone,
                      onChanged: (value) {
                        setState(() {
                          value = !isDone;
                        });
                      }),
                ],
              ),
              const Divider(
                color: Colors.purpleAccent,
                thickness: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.taks} ',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Divider(
                color: Colors.purpleAccent,
                thickness: 5,
              ),
              Text(
                'Usuario :${widget.user}',
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
              )
            ]),
          ],
        ),
      ),
    );
  }
}
