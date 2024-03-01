// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_todo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerTodo on ControllerTodoBase, Store {
  late final _$downloadURLAtom =
      Atom(name: 'ControllerTodoBase.downloadURL', context: context);

  @override
  String? get downloadURL {
    _$downloadURLAtom.reportRead();
    return super.downloadURL;
  }

  @override
  set downloadURL(String? value) {
    _$downloadURLAtom.reportWrite(value, super.downloadURL, () {
      super.downloadURL = value;
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

  late final _$imagemEscAtom =
      Atom(name: 'ControllerTodoBase.imagemEsc', context: context);

  @override
  XFile? get imagemEsc {
    _$imagemEscAtom.reportRead();
    return super.imagemEsc;
  }

  @override
  set imagemEsc(XFile? value) {
    _$imagemEscAtom.reportWrite(value, super.imagemEsc, () {
      super.imagemEsc = value;
    });
  }

  late final _$pathfotoAtom =
      Atom(name: 'ControllerTodoBase.pathfoto', context: context);

  @override
  String get pathfoto {
    _$pathfotoAtom.reportRead();
    return super.pathfoto;
  }

  @override
  set pathfoto(String value) {
    _$pathfotoAtom.reportWrite(value, super.pathfoto, () {
      super.pathfoto = value;
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

  late final _$addTaskAsyncAction =
      AsyncAction('ControllerTodoBase.addTask', context: context);

  @override
  Future<void> addTask(ModelTodo task) {
    return _$addTaskAsyncAction.run(() => super.addTask(task));
  }

  late final _$editarMensagemAsyncAction =
      AsyncAction('ControllerTodoBase.editarMensagem', context: context);

  @override
  Future<dynamic> editarMensagem(
      String id, String novoTitulo, String novaTarefa) {
    return _$editarMensagemAsyncAction
        .run(() => super.editarMensagem(id, novoTitulo, novaTarefa));
  }

  late final _$fetchTasksAsyncAction =
      AsyncAction('ControllerTodoBase.fetchTasks', context: context);

  @override
  Future<void> fetchTasks() {
    return _$fetchTasksAsyncAction.run(() => super.fetchTasks());
  }

  late final _$ControllerTodoBaseActionController =
      ActionController(name: 'ControllerTodoBase', context: context);

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
  dynamic removeList(String id) {
    final _$actionInfo = _$ControllerTodoBaseActionController.startAction(
        name: 'ControllerTodoBase.removeList');
    try {
      return super.removeList(id);
    } finally {
      _$ControllerTodoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
downloadURL: ${downloadURL},
tasks: ${tasks},
imagemEsc: ${imagemEsc},
pathfoto: ${pathfoto},
loading: ${loading}
    ''';
  }
}
