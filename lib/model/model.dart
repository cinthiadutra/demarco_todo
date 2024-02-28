import 'dart:convert';

class ModelTodo {
  String? id;
  String? titulo;
  List<String>? tarefas;
  String? image;
  bool isCompleted;
  ModelTodo({
    this.titulo,
    this.tarefas,
    this.id,
    this.image,
    required this.isCompleted,
  });

  @override
  String toString() =>
      'ModelTodo(id: $id,titulo: $titulo, tarefas: $tarefas, isCompleted: $isCompleted, image: $image)';

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'tarefas': tarefas,
      'isCompleted': isCompleted,
      'id': id,
      'image': image
    };
  }

  factory ModelTodo.fromMap(Map<String, dynamic> map) {
    return ModelTodo(
      id: map['id'],
      titulo: map['titulo'],
      tarefas: List<String>.from(map['tarefas']),
      isCompleted: map['isCompleted'] ?? false,
      image: map['image']
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelTodo.fromJson(String source) =>
      ModelTodo.fromMap(json.decode(source));
}
