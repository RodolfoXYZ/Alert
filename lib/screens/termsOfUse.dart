// ignore_for_file: file_names
import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso'),
        centerTitle: true, // Centralizar texto na AppBar
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Alinhar ao centro na coluna
              children: <Widget>[
                Text(
                  'Termos de Uso',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Pellentesque euismod semper ligula eget volutpat. '
                  'Vestibulum ante ipsum primis in faucibus orci luctus et '
                  'ultrices posuere cubilia Curae; Integer auctor sollicitudin '
                  'sapien, id venenatis nulla eleifend eu. Proin auctor '
                  'ullamcorper est, ut condimentum dui. Proin porta lorem eu '
                  'consequat consequat.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center, // Centralizar o texto
                ),
                SizedBox(height: 20),
                Text(
                  '1. Condições de Uso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Pellentesque euismod semper ligula eget volutpat. '
                  'Vestibulum ante ipsum primis in faucibus orci luctus et '
                  'ultrices posuere cubilia Curae; Integer auctor sollicitudin '
                  'sapien, id venenatis nulla eleifend eu. Proin auctor '
                  'ullamcorper est, ut condimentum dui. Proin porta lorem eu '
                  'consequat consequat.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center, // Centralizar o texto
                ),
                SizedBox(height: 20),
                Text(
                  '2. Responsabilidades do Usuário',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Pellentesque euismod semper ligula eget volutpat. '
                  'Vestibulum ante ipsum primis in faucibus orci luctus et '
                  'ultrices posuere cubilia Curae; Integer auctor sollicitudin '
                  'sapien, id venenatis nulla eleifend eu. Proin auctor '
                  'ullamcorper est, ut condimentum dui. Proin porta lorem eu '
                  'consequat consequat.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center, // Centralizar o texto
                ),
                SizedBox(height: 100), // Espaço extra no final para evitar que o conteúdo fique muito próximo da parte inferior da tela
              ],
            ),
          ),
        ),
      ),
    );
  }
}
