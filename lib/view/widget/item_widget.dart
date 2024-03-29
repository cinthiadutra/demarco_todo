import 'package:demarco_todo/model/model.dart';
import 'package:demarco_todo/view/page_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemWidget extends StatefulWidget {
  @observable
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
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(widget.item.tarefas),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.data),
              Text(widget.item.isCompleted == true ? 'Concluido' : 'Pendente'),
            ],
          ),
          onTap: widget.onTap,
          trailing: Observer(builder: (_) {
            return PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Editar'),
                            onTap: () {
                              Modular.to.pushNamed('/task');
                              Navigator.pop(context);
                            }),
                      ),
                      PopupMenuItem(
                          value: 1,
                          child: ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text('Excluir'),
                              onTap: () {
                                VxDialog.showConfirmation(context,
                                    content: const Text(
                                        'Voce tem certeza que desejar Excluir?'),
                                    onConfirmPress: () {
                                  widget.onRemove;
                                  Navigator.pop(context);
                                });
                              })),
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
                                setState(() {
                                  widget.item.isCompleted =
                                      !widget.item.isCompleted;
                                });

                                widget.onCompleted;
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
