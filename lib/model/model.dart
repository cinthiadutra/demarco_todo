import 'dart:convert';

class ModelTodo {
  String? id;
  DateTime? data;
  String? tarefas;
  String? image;
  bool isCompleted;
  ModelTodo({
    this.data,
    this.tarefas,
    this.id,
    this.image,
    required this.isCompleted,
  });

  @override
  String toString() =>
      'ModelTodo(id: $id,titulo: $data, tarefas: $tarefas, isCompleted: $isCompleted, image: $image)';

  Map<String, dynamic> toMap() {
    return {
      'titulo': data,
      'tarefas': tarefas,
      'isCompleted': isCompleted,
      'id': id,
      'image': image
    };
  }

  factory ModelTodo.fromMap(Map<String, dynamic> map) {
    return ModelTodo(
      id: map['id'],
      data: map['titulo'],
      tarefas: map['tarefas'],
      isCompleted: map['isCompleted'] ?? false,
      image: map['image']
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelTodo.fromJson(String source) =>
      ModelTodo.fromMap(json.decode(source));
}
