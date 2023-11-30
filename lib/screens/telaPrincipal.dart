// ignore_for_file: file_names

import 'package:alert/screens/occurrenceRecord.dart';
import 'package:flutter/material.dart';
import 'menu.dart';

class ScafoldTelaPrincipal extends StatelessWidget {
  const ScafoldTelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(body: TelaPrincipal());
  }
}

class MyScaffold extends StatelessWidget {
  final Widget body;
  const MyScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: Menu()),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Emergências",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 40.0, // Tamanho do ícone aumentado
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: body,
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OccurrenceRecord(initialOccurrenceType: "Samu"),
                    ),
                  );
                },
                child: const CaixaCall(texto: "Samu", cor: Colors.red),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OccurrenceRecord(initialOccurrenceType: "Bombeiro"),
                    ),
                  );
                },
                child: const CaixaCall(texto: "Bombeiro", cor: Colors.orange),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OccurrenceRecord(initialOccurrenceType: "Policia"),
                    ),
                  );
                },
                child: const CaixaCall(texto: "Policia", cor: Colors.blue),
              ),
            ],
          ),
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xff414141),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home_filled, size: 35, color: Colors.white),
                Icon(Icons.info_outline, size: 35, color: Colors.white),
                Icon(Icons.phone, size: 35, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff414141),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
            },
            child: const Icon(Icons.home_filled, size: 35, color: Colors.white),
          ),
          const Icon(Icons.info_outline, size: 35, color: Colors.white),
          const Icon(Icons.phone, size: 35, color: Colors.white),
        ],
      ),
    );
  }
}

class CaixaCall extends StatelessWidget {
  final String texto;
  final Color cor;

  const CaixaCall({super.key, required this.texto, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: cor, borderRadius: BorderRadius.circular(10)),
      width: 250,
      height: 110,
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 27,
        ),
      ),
    );
  }
}
