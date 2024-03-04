import 'package:date_format_field/date_format_field.dart';
import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/model/model.dart';
import 'package:demarco_todo/view/page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final postController = TextEditingController();
  final dataController = TextEditingController();
  final controllerTodo = Modular.get<ControllerTodo>();
  @observable
  bool isfoto = false;

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
                child: Observer(builder: (_) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                          visible: !isfoto, child: const Text('Selecione..')),
                      Visibility(
                          visible: isfoto,
                          child: Image.network(
                            controllerTodo.downloadURL ??
                                'https://www.demarco.com.br/index.html',
                            scale: 5.0,
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade200),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              )),
                          onPressed: () {
                            setState(() {
                              isfoto = !isfoto;
                            });
                            controllerTodo.getImage();
                          },
                          child: const Text(
                            'Upload',
                            style: TextStyle(fontSize: 10),
                          ))
                    ],
                  );
                }),
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
                          controllerTodo.listaTodoGeral.add(ModelTodo(
                              data: dataController.text,
                              tarefas: postController.text,
                              image: controllerTodo.downloadURL!,
                              isCompleted: false));
                        });
                        await controllerTodo.addTask(ModelTodo(
                            isCompleted: false,
                            tarefas: postController.text,
                            data: dataController.text,
                            image: controllerTodo.downloadURL!));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ItemPage()));
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ItemPage()));
                        setState(() {
                          controllerTodo.loading = true;
                          postController.clear();
                          dataController.clear();
                        });
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
