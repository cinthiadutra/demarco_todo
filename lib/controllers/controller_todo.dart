import 'package:demarco_todo/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
part 'controller_todo.g.dart';

class ControllerTodo = ControllerTodoBase with _$ControllerTodo;

abstract class ControllerTodoBase with Store {
  final databaseReference = FirebaseDatabase.instance.ref().child('tasks');
  @observable
  String pathImage = '';

  @observable
  String data = '';

  @observable
  String tarefa = '';

  @observable
  bool loading = false;

  @observable
  ObservableList<ModelTodo> tasks = ObservableList<ModelTodo>();

 final auth = FirebaseAuth.instance;

  @observable
  int currentIndex = 0; 
  @observable
  List<ModelTodo> itens = []; // Índice da imagem atual no VXSwiper

  @action
  void carregarItens(List<ModelTodo> itens) {
    this.itens = itens;
  }

  @action
  void atualizarIndice(int index) {
    currentIndex = index;
  }

  @action
  Future<void> fetchTasks() async {
    try {
      final dataSnapshot = await databaseReference.ref.once();
      final tasksMap = dataSnapshot as Map<dynamic, dynamic>;
      tasks.clear();
      tasksMap.forEach((taskId, taskData) {
        tasks.add(ModelTodo(
          id: taskId,
          tarefas: taskData['tarefas'],
          data: DateTime.parse(taskData['data']),
          image: taskData['image'],
          isCompleted: false,
        ));
      });
    } catch (error) {
      print('Error fetching tasks: $error');
      // Trate o erro conforme necessário (por exemplo, exibindo uma mensagem de erro para o usuário)
    }
  }

  @action
  Future<void> addTask(ModelTodo task) async {
    final newTaskRef = databaseReference.ref.push();
    await newTaskRef.set({
      'name': task.tarefas,
      'date': task.data?.toIso8601String(),
      'imageUrl': pathImage,
    });
    task.id = newTaskRef.key;
    tasks.add(task);
  }

   @action
  Future<void> updateTask(ModelTodo task) async {
    final newTaskRef = databaseReference.ref;
    await newTaskRef.update({
      'name': task.tarefas,
      'date': task.data?.toIso8601String(),
      'imageUrl': pathImage,
    });
    task.id = newTaskRef.key;
    tasks.add(task);
  }

  @action
  Future<void> deleteTask(String taskId) async {
    await databaseReference.child(taskId).remove();
    tasks.removeWhere((task) => task.id == taskId);
  }

  Future<String> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Salvando a imagem em algum lugar e retornando o caminho dela
      pathImage = pickedFile.path;
      return pickedFile.path;
    } else {
      // Usuário cancelou a seleção da imagem
      return '';
    }
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
}
