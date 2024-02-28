import 'dart:developer';

import 'package:demarco_todo/firebase_options.dart';
import 'package:demarco_todo/todo_module.dart';
import 'package:demarco_todo/view/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(ModularApp(module: TodoModule(), child: MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Notificação recebida em segundo plano: ${message.notification?.title}");

  // Você pode adicionar código aqui para lidar com a notificação em segundo plano,
  // como exibir uma notificação local ou realizar alguma ação com base na notificação.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
  }
}
