import 'package:demarco_todo/utils/utils.dart';
import 'package:demarco_todo/view/auth/login_screen.dart';
import 'package:demarco_todo/view/page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });

  _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) => setState(() {

              loading = false;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  ItemPage()));
            }))
        .onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira um email email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_open)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira um password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: 'nome', prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira um nome';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUp();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("você possui uma conta?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text('Login'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
