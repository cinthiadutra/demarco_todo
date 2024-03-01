import 'dart:convert';

class ModelTodo {
  String? id;
  String data;
  String tarefas;
  String image;
  bool isCompleted;
  ModelTodo({
    required this.data,
    required this.tarefas,
    this.id,
    required this.image,
    required this.isCompleted,
  });

  @override
  String toString() =>
      'ModelTodo(id: $id,data: $data, tarefas: $tarefas, isCompleted: $isCompleted, image: $image)';

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'tarefas': tarefas,
      'isCompleted': isCompleted,
      'id': id,
      'image': image
    };
  }

  factory ModelTodo.fromMap(Map<String, dynamic> map) {
    return ModelTodo(
        id: map['id'],
        data: map['data'],
        tarefas: map['tarefas'],
        isCompleted: map['isCompleted'] ?? false,
        image: map['image']);
  }

  String toJson() => json.encode(toMap());

  factory ModelTodo.fromJson(String source) =>
      ModelTodo.fromMap(json.decode(source));
}
