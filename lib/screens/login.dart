// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:alert/screens/cadastro.dart';
import 'package:alert/services/authenticate_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Caixas extends StatelessWidget {
  Caixas({super.key});

  final AuthenticateService authService = AuthenticateService();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void fazerLogin(BuildContext context) async {
    // Verifica se os campos de login e senha estão vazios
    if (loginController.text.isEmpty || senhaController.text.isEmpty) {
      // Exibe um alerta indicando que é necessário preencher ambos os campos
      showAlertDialog(context, 'Por favor, preencha usuário e senha');
      return;
    }

    try {
      User? user = await authService.fazerLogin(
        email: loginController.text,
        senha: senhaController.text,
      );

      if (user != null) {
        // Usuário autenticado com sucesso, exibe um alerta de sucesso
        showAlertDialog(context, 'Login efetuado com sucesso!');
        // Redireciona para a tela '/home' após um pequeno atraso para o usuário visualizar o alerta
        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
      } else {
        // Trata o caso em que a autenticação falhou (credenciais incorretas, erro de autenticação, etc.)
        showAlertDialog(context, 'E-mail e/ou senha incorretos. Favor, revise os dados e tente novamente!');
      }
    } catch (error) {
      // Lidar com possíveis erros durante o login
      showAlertDialog(context, 'Erro ao fazer login: $error');
    }
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alerta"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Acessar",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: loginController,
                        decoration: const InputDecoration(
                          hintText: "Login",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: senhaController,
                        obscureText: true, // Para campos de senha
                        decoration: const InputDecoration(
                          hintText: "Senha",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  fazerLogin(context); // Chame a função fazerLogin passando o BuildContext
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Acessar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // ignore: avoid_print
                  print("Esqueci minha senha");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: const Text(
                  "Esqueci minha senha",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 18,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cadastro()), // Navega para a tela de cadastro
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: const Text(
                  "Cadastre-se",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

