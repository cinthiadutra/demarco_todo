import 'package:demarco_todo/controllers/controller_todo.dart';
import 'package:demarco_todo/view/auth/login_screen.dart';
import 'package:demarco_todo/view/page_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TodoModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(ControllerTodo.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginScreen());
    r.child('/home', child: (context) => const PageScreen());
  }

  @override
  void exportedBinds(Injector i) {
    i.add(ControllerTodo.new);
    super.exportedBinds(i);
  }
}
