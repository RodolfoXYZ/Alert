import 'package:alert/screens/login.dart';
import 'package:alert/screens/occurrenceHistory.dart';
import 'package:alert/screens/personalData.dart';
import 'package:alert/screens/termsOfUse.dart';
import 'package:flutter/material.dart';
import '../services/authenticate_service.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Image.asset(
          "lib/asses/sirene.png",
          alignment: Alignment.center,
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PersonalData()),
            );
          },
          child: const OpcMenu(icone: Icons.person_2_outlined, texto: "Dados Pessoais"),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OccurrenceHistory()), // Navega para a página OccurrenceHistory
            );
          },
          child: const OpcMenu(icone: Icons.schedule, texto: "Histórico de Ocorrências"),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsOfUse()),
            );
          },
          child: const OpcMenu(icone: Icons.description_outlined, texto: "Termos de Uso"),
        ),
        InkWell(
          onTap: () async {
            // Chama a função de logout ao pressionar o botão "Sair"
            await AuthenticateService().fazerLogout();
            // ignore: avoid_print
            print('Logout realizado com sucesso!');
            // Após fazer logout, redireciona para a tela de login
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Caixas()),
            );
          },
          child: const OpcMenu(icone: Icons.exit_to_app_outlined, texto: "Sair"),
        ),
      ],
    );
  }
}

class OpcMenu extends StatelessWidget {
  final IconData icone;
  final String texto;

  const OpcMenu({
    super.key,
    required this.icone,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icone,
            size: 40,
            color: const Color(0xff424242),
          ),
          const SizedBox(width: 10),
          Text(
            texto,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
