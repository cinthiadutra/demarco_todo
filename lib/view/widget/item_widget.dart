import 'package:demarco_todo/model/model.dart';
import 'package:demarco_todo/view/page_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemWidget extends StatelessWidget {
  final ModelTodo item;
  final VoidCallback onTap;
  final VoidCallback onCompleted;
  final int index;
  final VoidCallback onRemove;

  const ItemWidget(
      {Key? key,
      required this.item,
      required this.onTap,
      required this.onCompleted,
      required this.index,
      required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(item.tarefas),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.data),
              Text(item.isCompleted == true ? 'Concluido' : 'Pendente'),
            ],
          ),
          onTap: onTap,
          trailing: Observer(builder: (_) {
            return PopupMenuButton(
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
                                        titulo: item.data,
                                        tarefa: item.tarefas,
                                      ))),
                        ),
                      ),
                      PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Excluir'),
                            onTap: () {
                              onRemove;
                            },
                          )),
                      PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Concluir'),
                            onTap: () {
                              VxDialog.showConfirmation(context,
                                  content:
                                      const Text('Voce concluiu a tarefa?'),
                                  onConfirmPress: () {
                                item.isCompleted = !item.isCompleted;
                                onCompleted;
                                Navigator.pop(context);
                              });
                            },
                          )),
                    ]);
          }),
        ),
      ],
    );
  }
}
