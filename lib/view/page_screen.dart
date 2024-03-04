import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/model/model.dart';
import 'package:demarco_todo/view/add_List.dart';
import 'package:demarco_todo/view/widget/carousel_widegte.dart';
import 'package:demarco_todo/view/widget/item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ItemPage extends StatelessWidget {
  final store = Modular.get<ControllerTodo>();
  final auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref().orderByChild('date');

  ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseFoto = FirebaseDatabase.instance
        .ref()
        .child('id')
        .equalTo(auth.currentUser?.email);

    return Scaffold(
      body: Observer(
        builder: (_) {
          return Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Demarco Todo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 200,
                  child: FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: databaseFoto,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return CarouselWidget(
                            imagens: [snapshot.child('image').value.toString()]
                            // Lista de URLs das imagens
                            );
                      }),
                ),
                FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: databaseRef,
                  defaultChild: const Text('Loading'),
                  itemBuilder: (context, snapshot, animation, index) {
                    return ItemWidget(
                      index: index,
                      item: ModelTodo(
                          data: snapshot.child('date').value.toString(),
                          tarefas: snapshot.child('tarefa').value.toString(),
                          isCompleted:
                              snapshot.child('isCompleted').value == true
                                  ? true
                                  : false,
                          image: snapshot.child('image').value.toString(),
                          id: snapshot.child('id').value.toString()),
                      onTap: () {},
                      onCompleted: () {
                        // Implementar a lógica para concluir o item aqui,
                        // por exemplo:
                        store.databaseRef
                            .ref(store.tasks[index].id)
                            .update({'isCompleted': true});
                      },
                      onRemove: () {
                        store.removeList(store.tasks[index].id!);
                      },
                    );
                  },
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
