import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/utils/utils.dart';
import 'package:demarco_todo/view/add_List.dart';
import 'package:demarco_todo/view/auth/login_screen.dart';
import 'package:demarco_todo/view/page_tasks.dart';
import 'package:demarco_todo/view/widget/cards_todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
      body: Observer(builder: (_) {
        return
            // Column(
            //   children: [
            //     FutureBuilder(
            //       future: controller.getData(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasError) {
            //        Container();
            //         }
            //         if (snapshot.connectionState == ConnectionState.done) {
            //           return VxSwiper(
            //               items: [ Image.network(
            //                   snapshot.datatoString(),
            //                 )]
            //               );
            //         }
            //         return const Center(child: CircularProgressIndicator());
            //       },
            //     ),

            ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .8,
              height: 300,
              child: FutureBuilder(
                  future: controller.storage
                      .ref()
                      .child("${controller.modeloUsado?.id}")
                      .listAll(),
                  builder: (context, snapshot) {
                    final images = snapshot.data?.items.toList();
                    return VxSwiper(items: [Image.network(images.toString())]);
                  }),
            ),
            FirebaseAnimatedList(
                shrinkWrap: true,
                query: controller.databaseReference,
                defaultChild: const Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {
                  final tarefa = snapshot.child('tarefa').value.toString();
                  final data = snapshot.child('date').value.toString();

                  return ListTile(
                    title: CardTodo(
                      data: snapshot.child('date').value.toString(),
                      taks: snapshot.child('tarefa').value.toString(),
                      user: snapshot.child('user').value.toString(),
                      id: snapshot.child('id').value.toString(),
                      complet: snapshot.child('completed').value.toString(),
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
                                                titulo: tarefa,
                                                tarefa: data,
                                              ))),
                                ),
                              ),
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Excluir'),
                                    onTap: () {
                                      controller.removeList(snapshot
                                          .child('id')
                                          .value
                                          .toString());
                                    },
                                  )),
                            ]),
                  );
                }),
          ],
        );
        //   ],
        // );
      }),
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
