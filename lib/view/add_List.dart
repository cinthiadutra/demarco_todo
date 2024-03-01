import 'package:date_format_field/date_format_field.dart';
import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final postController = TextEditingController();
  final taskController = TextEditingController();
  final dataController = TextEditingController();
  final controllerTodo = Modular.get<ControllerTodo>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 1,
                controller: postController,
                decoration: const InputDecoration(
                    hintText: 'Nome da Tarefa', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all()),
                child: DateFormatField(
                    controller: dataController,
                    onComplete: (date) {
                      if (date != null) {
                        setState(() {
                          controllerTodo.dataTask = date.toString();
                        });
                      }
                    },
                    type: DateFormatType.type4),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * .9,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all()),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('  Selecione o arquivo..'),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey.shade200),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            )),
                        onPressed: () {
                          controllerTodo.getImage();
                        },
                        child: const Text(
                          'Enviar',
                          style: TextStyle(fontSize: 10),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade200),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          )),
                      child: const Text('Salvar'),
                      onPressed: () async {
                        setState(() {
                          controllerTodo.loading = true;
                          controllerTodo.post = postController.text;
                          controllerTodo.dataTask = dataController.text;
                          controllerTodo.ListTask.add(taskController.text);
                        });
                        await controllerTodo.addTask(ModelTodo(
                            isCompleted: false,
                            tarefas: postController.text,
                            data: dataController.text,
                            image: controllerTodo.imagemEsc?.path ?? ''));
                        Modular.to.pop();
                        Modular.to.pop();
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade200),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          )),
                      child: const Text('Cancelar'),
                      onPressed: () async {
                        setState(() {
                          controllerTodo.loading = true;
                          postController.clear();
                          taskController.clear();
                          dataController.clear();
                        });
                        Modular.to.navigate('/home');
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // void AddList() {
  //   setState(() {
  //     loading = true;
  //   });

  //   String id = DateTime.now().millisecondsSinceEpoch.toString();
  //   databaseRef.child(id).set({
  //     'title': postController.text.toString(),
  //     'id': DateTime.now().millisecondsSinceEpoch.toString(),
  //     'task': task.text.toString(),
  //   }).then((value) {
  //     Utils().toastMessage('Lista Adicionada');
  //     setState(() {
  //       loading = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     Utils().toastMessage(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }
  // void RemoveList() {
  //   setState(() {
  //     loading = true;
  //   });

  //   String id = DateTime.now().millisecondsSinceEpoch.toString();
  //   databaseRef.child(id).remove().then((value) {
  //     Utils().toastMessage('Lista Apagada');
  //     setState(() {
  //       loading = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     Utils().toastMessage(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }

  //   void AddTask() {
  //   setState(() {
  //     loading = true;
  //   });

  //   String id = DateTime.now().millisecondsSinceEpoch.toString();
  //   databaseRef.child(id).update({
  //     'task': task.text.toString(),
  //   }).then((value) {
  //     Utils().toastMessage('Lista Adicionada');
  //     setState(() {
  //       loading = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     Utils().toastMessage(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }
}
