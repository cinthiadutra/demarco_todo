import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/utils/utils.dart';
import 'package:demarco_todo/view/add_List.dart';
import 'package:demarco_todo/view/auth/login_screen.dart';
import 'package:demarco_todo/view/page_tasks.dart';
import 'package:demarco_todo/view/widget/cards_todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({Key? key}) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  final auth = FirebaseAuth.instance;

  bool loading = false;
  final controller = Modular.get<ControllerTodo>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Demarco Tarefas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
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
      body: Observer(
        builder: (_) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: controller.fetchTasks(),
                    builder: (context, index) {
                      return ListView.builder(
                          itemCount: controller.tasks.length,
                          itemBuilder: (context, index) {
                            ListView(
                              shrinkWrap: true,
                              children: [
                              VxSwiper(items: [
                                Image.network(
                                    controller.itens[index].image ?? '')
                              ]),
                              
                              ListTile(
                    title: CardTodo(
                      title:controller.auth.currentUser?.displayName,
                      taks: controller.itens[index].tarefas,
                      data:DateFormat().format( controller.itens[index].data??DateTime.now()),
              
                    ),
                    trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('Editar'),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PageTask(
                                                index: index,
                                                data: controller.data,
                                                tarefa: controller.tarefa,
                                              ))),
                                ),
                              ),
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Excluir'),
                                    onTap: () {
                                      controller.databaseReference.remove();
                                    },
                                  )),
                            ]),
                  )
                        
                            ]);
                          });
                    },
                  ),
                ),
                
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddList()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
