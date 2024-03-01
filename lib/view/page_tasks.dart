import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/utils/utils.dart';
import 'package:demarco_todo/view/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:velocity_x/velocity_x.dart';

class PageTask extends StatefulWidget {
  final int? index;
  String? titulo;
  String? tarefa;
  String? path;
  PageTask({
    Key? key,
    this.index,
    this.titulo,
    this.tarefa,
  }) : super(key: key);

  @override
  State<PageTask> createState() => _PageTaskState();
}

class _PageTaskState extends State<PageTask> {
  final controllerTodo = Modular.get<ControllerTodo>();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  final editControntroller = TextEditingController();
  final editTaskControntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    editControntroller.text = widget.titulo!;
    editTaskControntroller.text = widget.tarefa!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.logout_outlined),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(shrinkWrap: true, children: [
            TextField(
              controller: editControntroller,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: editTaskControntroller,
              decoration: const InputDecoration(
                  hintMaxLines: 4, border: OutlineInputBorder()),
            ),
            TextButton(
                onPressed: () {
                  controllerTodo.getImage();
                },
                child: const Text('Trocar foto')),
            Image.network(controllerTodo.imagemEsc!.path)
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controllerTodo.editarMensagem(
              auth.currentUser?.displayName ?? 'anonimous',
              editControntroller.text,
              editTaskControntroller.text);
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
