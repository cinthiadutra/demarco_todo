import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/model/model.dart';
import 'package:demarco_todo/view/add_List.dart';
import 'package:demarco_todo/view/page_tasks.dart';
import 'package:demarco_todo/view/widget/item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final store = Modular.get<ControllerTodo>();

  final auth = FirebaseAuth.instance;

  final databaseRef = FirebaseDatabase.instance.ref().orderByChild('date');

  @override
  Widget build(BuildContext context) {
    final databaseFoto = FirebaseDatabase.instance.ref();

    return Scaffold(
      drawer: const Drawer(),
      body: Observer(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      '.Demarco Todo',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: FirebaseAnimatedList(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          query: databaseFoto,
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            return Image.network(
                                snapshot.child('image').value.toString()
                                // Lista de URLs das imagens
                                );
                          }),
                    ),
                  ),
                  const Divider(),
                  FirebaseAnimatedList(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    query: databaseRef,
                    defaultChild: const Text('Loading'),
                    itemBuilder: (context, snapshot, animation, indext) {
                      return InkWell(
                        onTap: () {
                          VxDialog.showAlert(context, onPressed: () {
                            Navigator.pop(context);
                          },
                              content: SizedBox(
                                height: 400,
                                width: 300,
                                child: Column(
                                  children: [
                                    Image.network(snapshot
                                        .child('image')
                                        .value
                                        .toString()),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(snapshot
                                        .child('tarefa')
                                        .value
                                        .toString()),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                        snapshot.child('data').value.toString())
                                  ],
                                ),
                              ));
                        },
                        child: ItemWidget(
                          index: indext,
                          item: ModelTodo(
                              data: snapshot.child('date').value.toString(),
                              tarefas:
                                  snapshot.child('tarefa').value.toString(),
                              isCompleted:
                                  snapshot.child('isCompleted').value == true
                                      ? true
                                      : false,
                              image: snapshot.child('image').value.toString(),
                              id: snapshot.child('id').value.toString()),
                          onTap: () {},
                          onCompleted: () async {
                            await store.databaseRef
                                .ref()
                                .update({'isCompleted': true});
                          },
                          onRemove: () {
                            store.deleteItem(indext);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
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
