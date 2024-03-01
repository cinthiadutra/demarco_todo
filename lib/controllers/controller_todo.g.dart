// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_todo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerTodo on ControllerTodoBase, Store {
  late final _$pathImageAtom =
      Atom(name: 'ControllerTodoBase.pathImage', context: context);

  @override
  String get pathImage {
    _$pathImageAtom.reportRead();
    return super.pathImage;
  }

  @override
  set pathImage(String value) {
    _$pathImageAtom.reportWrite(value, super.pathImage, () {
      super.pathImage = value;
    });
  }

  late final _$dataAtom =
      Atom(name: 'ControllerTodoBase.data', context: context);

  @override
  String get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(String value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$tarefaAtom =
      Atom(name: 'ControllerTodoBase.tarefa', context: context);

  @override
  String get tarefa {
    _$tarefaAtom.reportRead();
    return super.tarefa;
  }

  @override
  set tarefa(String value) {
    _$tarefaAtom.reportWrite(value, super.tarefa, () {
      super.tarefa = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'ControllerTodoBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$tasksAtom =
      Atom(name: 'ControllerTodoBase.tasks', context: context);

  @override
  ObservableList<ModelTodo> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<ModelTodo> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: 'ControllerTodoBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$itensAtom =
      Atom(name: 'ControllerTodoBase.itens', context: context);

  @override
  List<ModelTodo> get itens {
    _$itensAtom.reportRead();
    return super.itens;
  }

  @override
  set itens(List<ModelTodo> value) {
    _$itensAtom.reportWrite(value, super.itens, () {
      super.itens = value;
    });
  }

  late final _$fetchTasksAsyncAction =
      AsyncAction('ControllerTodoBase.fetchTasks', context: context);

  @override
  Future<void> fetchTasks() {
    return _$fetchTasksAsyncAction.run(() => super.fetchTasks());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('ControllerTodoBase.addTask', context: context);

  @override
  Future<void> addTask(ModelTodo task) {
    return _$addTaskAsyncAction.run(() => super.addTask(task));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('ControllerTodoBase.updateTask', context: context);

  @override
  Future<void> updateTask(ModelTodo task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(task));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('ControllerTodoBase.deleteTask', context: context);

  @override
  Future<void> deleteTask(String taskId) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(taskId));
  }

  late final _$ControllerTodoBaseActionController =
      ActionController(name: 'ControllerTodoBase', context: context);

  @override
  void carregarItens(List<ModelTodo> itens) {
    final _$actionInfo = _$ControllerTodoBaseActionController.startAction(
        name: 'ControllerTodoBase.carregarItens');
    try {
      return super.carregarItens(itens);
    } finally {
      _$ControllerTodoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void atualizarIndice(int index) {
    final _$actionInfo = _$ControllerTodoBaseActionController.startAction(
        name: 'ControllerTodoBase.atualizarIndice');
    try {
      return super.atualizarIndice(index);
    } finally {
      _$ControllerTodoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void atualizarBancoDeDadosEEnviarNotificacao() {
    final _$actionInfo = _$ControllerTodoBaseActionController.startAction(
        name: 'ControllerTodoBase.atualizarBancoDeDadosEEnviarNotificacao');
    try {
      return super.atualizarBancoDeDadosEEnviarNotificacao();
    } finally {
      _$ControllerTodoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pathImage: ${pathImage},
data: ${data},
tarefa: ${tarefa},
loading: ${loading},
tasks: ${tasks},
currentIndex: ${currentIndex},
itens: ${itens}
    ''';
  }
}
