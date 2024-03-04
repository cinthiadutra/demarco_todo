import 'dart:developer';
import 'dart:io';

import 'package:demarco_todo/model/model.dart';
import 'package:demarco_todo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
part 'controller_todo.g.dart';

class ControllerTodo = ControllerTodoBase with _$ControllerTodo;

abstract class ControllerTodoBase with Store {
  final databaseRef = FirebaseDatabase.instance;
  final taskController = TextEditingController();
  final postController = TextEditingController();
  var dataController = TextEditingController();
  ModelTodo? modeloUsado;
  String post = '';
  String? task = '';
  String? dataTask = '';
  @observable
  String? downloadURL = '';
  @observable
  ObservableList<ModelTodo> tasks = ObservableList<ModelTodo>();
  @observable
  XFile? imagemEsc;
  @observable
  String pathfoto = '';
  List<ModelTodo> listaTodoGeral = [];

  ObservableList<String> listTask = ObservableList.of([]);
  @observable
  bool loading = false;
  final auth = FirebaseAuth.instance;

  // @action
  // Future addTodo() async {
  //   final String ids = _auth.currentUser?.email ?? 'anonimous';
  //   loading = true;

  //   await databaseRef.child(ids).set({
  //     'Usuario': _auth.currentUser?.email,
  //     'Tarefa': post,
  //     'data': dataTask,
  //     'image': imagemEsc,
  //   }).then((value) {
  //     modeloUsado =
  //         ModelTodo(isCompleted: false, data: post, tarefas: ListTask);
  //     Utils().toastMessage('Conteudo Adicionado');
  //     Modular.to.pop();
  //     postController.clear();
  //     dataController.clear();
  //     loading = false;
  //   }).onError((error, stackTrace) {
  //     Utils().toastMessage(error.toString());

  //     loading = false;
  //   });
  // }

  @action
  Future<void> addTask(ModelTodo task) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().push();
    String? id = auth.currentUser?.email;
    ref.set({
      'tarefa': task.tarefas,
      'date': task.data,
      'image': downloadURL,
      'id': auth.currentUser?.email,
      'isCompleted': task.isCompleted
    });
    tasks.add(task);

    Modular.to.popUntil(ModalRoute.withName('/home'));
  }

  @action
  Future editarMensagem(String id, String novoTitulo, String novaTarefa) async {
    final String id = auth.currentUser?.displayName ?? 'anonimous';
    await databaseRef.ref(id).update({
      "title": novoTitulo,
    }).then((_) {
      log("Mensagem editada com sucesso");
    }).catchError((error) {
      log("Erro ao editar mensagem: $error");
    });
    await databaseRef.ref(id).update({
      "task": novaTarefa,
    }).then((_) {
      log("Mensagem editada com sucesso");
    }).catchError((error) {
      log("Erro ao editar mensagem: $error");
    });
    Modular.to.pop();
    Modular.to.pop();
  }

  @action
  void atualizarBancoDeDadosEEnviarNotificacao() {
    // Atualize o banco de dados Firebase Realtime
    // ...

    // Envie uma notificação por meio do FCM
    FirebaseMessaging.instance.subscribeToTopic('atualizacao_banco');
    FirebaseMessaging.instance.sendMessage(data: {
      'title': 'Atualização no banco de dados',
      'body': 'Seu banco de dados foi atualizado!',
    });
  }

  @action
  removeList(String id) {
    final String ids = auth.currentUser?.displayName ?? 'anonimous';
    loading = true;

    databaseRef.ref().child(ids).remove().then((value) {
      Utils().toastMessage('Lista Apagada');
      Modular.to.pop();
      loading = false;
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());

      loading = false;
    });
  }

  final Reference storage = FirebaseStorage.instance.ref();
@action
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    //Import dart:core
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceImage = storage.child('images');
    Reference referenceImageToUpload = referenceImage.child(uniqueFileName);
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file.path));
      //Success: get the download URL
      downloadURL = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
  }

  

}
