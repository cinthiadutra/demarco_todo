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
  final databaseRef = FirebaseDatabase.instance.ref('task');
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
  final List<String> ListTask = [];
  ObservableList<String> listFoto = ObservableList.of([]);
  @observable
  bool loading = false;
  final _auth = FirebaseAuth.instance;

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
    final newTaskRef = databaseReference.push();
    await newTaskRef.set({
      'tarefa': task.tarefas,
      'date': task.data,
      'imageUrl': imagemEsc?.path,
      'id': newTaskRef.key,
      'isCompleted': task.isCompleted
    });
    task.id = newTaskRef.key!;
    tasks.add(task);
    File file = File(imagemEsc!.path);
    final pathImages = 'img-${DateTime.now().toString()}.jpg';
    String ref = '${task.id}/$pathImages';
    await storage.ref(ref).putFile(file);
    Modular.to.popUntil(ModalRoute.withName('/home'));
  }

  @action
  Future editarMensagem(String id, String novoTitulo, String novaTarefa) async {
    final String id = _auth.currentUser?.displayName ?? 'anonimous';
    await databaseRef.child(id).update({
      "title": novoTitulo,
    }).then((_) {
      log("Mensagem editada com sucesso");
    }).catchError((error) {
      log("Erro ao editar mensagem: $error");
    });
    await databaseRef.child(id).update({
      "task": novaTarefa,
    }).then((_) {
      log("Mensagem editada com sucesso");
    }).catchError((error) {
      log("Erro ao editar mensagem: $error");
    });
    Modular.to.pop();
    Modular.to.pop();
  }

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
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
    final String ids = _auth.currentUser?.displayName ?? 'anonimous';
    loading = true;

    databaseRef.child(ids).remove().then((value) {
      Utils().toastMessage('Lista Apagada');
      Modular.to.pop();
      loading = false;
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());

      loading = false;
    });
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imagemEsc = image;
    return image!.path;
  }

  Future<void> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      await storage.ref(ref).putFile(file);
      listFoto.add(ref);
      pathfoto = ref;
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload');
    }
  }

  Future getData() async {
    try {
      await getImageMemory(imagemEsc!.path);
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> getImageMemory(String taskid) async {
    downloadURL = await storage.ref(imagemEsc!.path).getDownloadURL();
    log(downloadURL.toString());
  }

  // pickAndUploadImage() async {
  //   XFile? file = await getImage();
  //   if (file != null) {
  //     await upload(file.path);
  //   }
  // }

  @action
  Future<void> fetchTasks() async {
    try {
      final dataSnapshot =
          await databaseReference.ref.once(DatabaseEventType.value);
      final tasksMap = dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
      tasks.clear();
      tasksMap.forEach((taskId, taskData) {
        tasks.add(ModelTodo(
          id: taskId,
          tarefas: taskData['tarefas'],
          data: taskData['date'],
          image: taskData['imageUrl'],
          isCompleted: false,
        ));
      });
    } catch (error) {
      print('Error fetching tasks: $error');
      // Trate o erro conforme necessário (por exemplo, exibindo uma mensagem de erro para o usuário)
    }
  }
}
